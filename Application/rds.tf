
resource "random_password" "cint_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "cint" {
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.admin_username
  password               = random_password.cint_password.result
  vpc_security_group_ids = [aws_security_group.cint_db.id]
  db_subnet_group_name   = aws_db_subnet_group.cint_db.name
  deletion_protection    = true
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "cint_db" {
  name       = var.db_subnet
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = var.db_subnet
  }
}

