resource "aws_rds_cluster" "default" {
  cluster_identifier        = "master-dev-database-cluster"
  engine                    = "aurora-mysql"
  engine_version            = "5.6.mysql_aurora.1.20.1"
  database_name             = "dev-db"
  db_cluster_instance_class = "db.t3.medium"
  master_username           = "sq_dance_adm"
  master_password           = "***REMOVED***"
  vpc_security_group_ids    = "RDS_DevWork"
  //password authentication is enabled
}