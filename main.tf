resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 2
  cluster_identifier   = aws_rds_cluster.master-dev-db-cluster.id
  db_subnet_group_name = aws_db_subnet_group.RDS_dev_subnet.name
  instance_class       = "db.t3.medium"
  engine               = aws_rds_cluster.master-dev-db-cluster.engine
  engine_version       = aws_rds_cluster.master-dev-db-cluster.engine_version
  publicly_accessible  = "true"
}

resource "aws_rds_cluster" "master-dev-db-cluster" {
  cluster_identifier = "master-dev-db-cluster"
  engine             = "aurora"
  //engine_mode            = "provisioned"
  engine_version         = "5.6.mysql_aurora.1.20.1"
  database_name          = "dev-db"
  master_username        = "sq_dance_adm"
  master_password        = var.db_password
  vpc_security_group_ids = [aws_security_group.RDS_DevWork.id]
  //password authentication is enabled as default
}

resource "aws_db_subnet_group" "RDS_dev_subnet" {
  name       = "rds_dev_subnet"
  subnet_ids = ["subnet-0faaa007ed499eda5", "subnet-0444b1b614a8528da"]
}

resource "aws_security_group" "RDS_DevWork" {
  name   = "RDS_DevWork"
  vpc_id = "vpc-093da92b6cda0a2d6"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
