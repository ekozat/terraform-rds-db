resource "aws_rds_cluster_instance" "cluster_instances" {
  count               = 2
  cluster_identifier  = aws_rds_cluster.master-dev-db-cluster.id
  instance_class      = "db.t3.medium"
  engine              = aws_rds_cluster.master-dev-db-cluster.engine
  engine_version      = aws_rds_cluster.master-dev-db-cluster.engine_version
  publicly_accessible = "true"
}

resource "aws_rds_cluster" "master-dev-db-cluster" {
  cluster_identifier = "master-dev-db-cluster"
  engine             = "aurora"
  //engine_mode            = "provisioned"
  engine_version         = "5.6.mysql_aurora.1.20.1"
  database_name          = "dev-db"
  master_username        = "sq_dance_adm"
  master_password        = "***REMOVED***"
  vpc_security_group_ids = ["RDS_DevWork"]
  //password authentication is enabled
}
