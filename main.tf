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
  vpc_security_group_ids = [aws_security_group.RDS_DevWork.id]
  //password authentication is enabled as default
}

resource "aws_security_group" "RDS_DevWork" {
  name   = "RDS_DevWork"
  vpc_id = aws_vpc.RDS_DevWork.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_vpc" "RDS_DevWork" {
  cidr_block = "10.0.2.32/27"
}
