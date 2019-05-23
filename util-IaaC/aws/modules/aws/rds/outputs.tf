##################################################################################
# OUTPUT
##################################################################################

output "database_id" {
  value = "${aws_rds_cluster.aurora_cluster.id}"
}

output "database_endpoint" {
  value = "${aws_rds_cluster.aurora_cluster.endpoint}"
}

output "database_port" {
  value = "${aws_rds_cluster.aurora_cluster.port}"
}

output "database_name" {
  value = "${aws_rds_cluster.aurora_cluster.database_name}"
}

output "database_username" {
  value = "${aws_rds_cluster.aurora_cluster.master_username}"
}

output "database_password" {
  value     = "${aws_rds_cluster.aurora_cluster.master_password}"
  sensitive = true
}
