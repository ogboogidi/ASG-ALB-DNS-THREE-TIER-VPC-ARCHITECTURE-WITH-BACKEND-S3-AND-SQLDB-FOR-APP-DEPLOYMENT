#create db subnet group dependency in which the db will be deployed

resource "aws_db_subnet_group" "db_private_subnets" {
  name = "dbprivatesubnets"
  subnet_ids = var.luxe_db_subnets[*]
}


#dependency to fetch the db password

data "aws_secretsmanager_secret" "db_password_secret" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_password_secret.id
  

}


#create the postgress db

resource "aws_db_instance" "luxe_db" {
  allocated_storage = var.allocated_storage
  db_name = var.db_name
  engine = "postgres"
  engine_version = "17.4"
  instance_class = var.instance_class
  username = var.username
  password = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["dbpassword"]
  db_subnet_group_name = aws_db_subnet_group.db_private_subnets.name
  vpc_security_group_ids = [var.luxe_db_sg]
  skip_final_snapshot = true
  publicly_accessible = false

  tags = merge(var.tags,
    {
    Name = "${var.tags.project}-${var.tags.application}-${var.tags.environment}-db"
    }
    )

}
