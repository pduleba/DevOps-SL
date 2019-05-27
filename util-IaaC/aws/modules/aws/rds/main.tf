##################################################################################
# TERRAFORM
##################################################################################

terraform {
  # values injected by `name` from file specied on `init` via `-backend-config` parameter
  # not in use by 'plan'/'apply'/'destroy' once initialized
  # for locking use 'lock_table' of AWS DynamoDB - see https://www.terraform.io/docs/backends/types/s3.html#lock_table
  backend "s3" {}
}

##################################################################################
# RESOURCES
##################################################################################

# TODO : Add custom aws_db_option_group & custom aws_appautoscaling_target
# See for more details https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/blob/master/main.tf

resource "aws_rds_cluster" "aurora_cluster" {

  # Identifiers - must contain only ASCII letters, digits, and hyphens
  cluster_identifier = "${format(
    "%s-%s",
    local.RDS_IDENTIFIER,
    "aurora-cluster"
  )}"

  # Engine options
  engine         = "${var.rds_engine}"
  engine_mode    = "${var.rds_engine_mode}"
  engine_version = "${var.rds_engine_version}"

  # Configuration
  port                            = "${var.database_port}"
  database_name                   = "${var.database_name}"
  master_username                 = "${var.database_username}"
  master_password                 = "${local.MASTER_PASSWORD}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.name}"

  # Network & Security
  db_subnet_group_name   = "${aws_db_subnet_group.aurora_subnet_group.name}"
  vpc_security_group_ids = "${list(data.aws_security_group.security_group_private_rds.id)}"
  // availability_zones - calculated by `db_subnet_group_name`
  deletion_protection = false

  # Maintenance
  preferred_maintenance_window = "${local.PREFERRED_MAINTENANCE_WINDOW}"
  apply_immediately            = false

  # Encryption
  storage_encrypted = false

  # Failover

  # Backup
  backup_retention_period = "${local.BACKUP_RETENTION_PERIOD}"
  preferred_backup_window = "${local.PREFERRED_BACKUP_WINDOW}"
  copy_tags_to_snapshot   = true
  skip_final_snapshot     = true

  # Backtracking
  backtrack_window = 0 // Disable backtracking

  # Monitoring

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "aurora_cluster"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  # Loop
  count = 2 // Master(Writer) & ReadReplicas (Reader) = (count-1)

  # Identifiers - must contain only ASCII letters, digits, and hyphens
  identifier = "${format(
    "%s-%s",
    local.RDS_IDENTIFIER,
    count.index
  )}"
  instance_class     = "${var.rds_instance_class}"
  cluster_identifier = "${aws_rds_cluster.aurora_cluster.id}"

  # Engine options
  engine         = "${var.rds_engine}"
  engine_version = "${var.rds_engine_version}"

  # Configuration
  db_parameter_group_name = "${aws_db_parameter_group.aurora_parameter_group.name}"

  # Network & Security
  db_subnet_group_name = "${aws_db_subnet_group.aurora_subnet_group.name}"
  publicly_accessible  = false

  # Maintenance
  preferred_maintenance_window = "${local.PREFERRED_MAINTENANCE_WINDOW}"
  apply_immediately            = true
  auto_minor_version_upgrade   = true

  # Encryption

  # Failover
  promotion_tier = 0 // Default failover priority

  # Backup
  copy_tags_to_snapshot = false
  // preferred_backup_window - must be defined on cluster level

  # Backtracking

  # Monitoring
  monitoring_interval          = 0 // Disable enhanced monitoring
  performance_insights_enabled = false


  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "aurora_cluster_instance"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    "aurora_subnet_group"
  )}"

  description = "DevOps upskill AWS Aurora subnet group"
  subnet_ids  = "${data.aws_subnet.subnets_private.*.id}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "aurora_subnet_group"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  #  must contain only ASCII letters, digits, and hyphens
  name = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    "aurora-cluster-parameter-group"
  )}"

  description = "DevOps upskill AWS Aurora cluster parameter group"
  family      = "${var.rds_cluster_parameter_group}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "aurora_cluster_parameter_group"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
  #  must contain only ASCII letters, digits, and hyphens
  name = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    "aurora-parameter-group"
  )}"

  description = "DevOps upskill RDS parameter group"
  family      = "${var.rds_parameter_group}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "aurora_parameter_group"
      )
    ),
    module.commons.tags
  )}"
}
