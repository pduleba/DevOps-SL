##################################################################################
# RESOURCES
##################################################################################

# TODO : Add custom aws_db_option_group & custom aws_appautoscaling_target
# See for more details https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/blob/master/main.tf

resource "aws_rds_cluster" "aurora_cluster" {

  cluster_identifier = "${module.aurora-cluster.name}"

  # Engine options
  engine         = "${var.rds_engine}"
  engine_mode    = "${var.rds_engine_mode}"
  engine_version = "${var.rds_engine_version}"

  # Configuration
  port                            = "${var.database_port}"
  database_name                   = "${var.database_name}"
  master_username                 = "${var.database_username}"
  master_password                 = "${module.password-generator.password}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.name}"

  # Network & Security
  db_subnet_group_name   = "${aws_db_subnet_group.aurora_subnet_group.name}"
  vpc_security_group_ids = "${list(data.aws_security_group.rds.id)}"
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

  tags = "${module.aurora-cluster.tags}"
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  # Loop
  count = 2 // Master(Writer) & ReadReplicas (Reader) = (count-1)

  # Identifiers - must contain only ASCII letters, digits, and hyphens
  identifier = "${format(
    "%s-%s",
    module.aurora-cluster-instance.name,
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


  tags = "${module.aurora-cluster-instance.tags}"
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name = "${module.aurora-subnet-group.name}"

  description = "${module.aurora-subnet-group.description}"
  subnet_ids  = "${data.aws_subnet.private.*.id}"

  tags = "${module.aurora-subnet-group.tags}"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name = "${module.aurora-cluster-parameter-group.name}"

  description = "${module.aurora-cluster-parameter-group.description}"
  family      = "${var.rds_cluster_parameter_group}"

  tags = "${module.aurora-cluster-parameter-group.tags}"
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
  name = "${module.aurora-parameter-group.name}"

  description = "${module.aurora-parameter-group.description}"
  family      = "${var.rds_parameter_group}"

  tags = "${module.aurora-parameter-group.tags}"
}
