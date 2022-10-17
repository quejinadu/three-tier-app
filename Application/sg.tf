resource "aws_security_group" "alb_sg" {
  name_prefix = var.sg_name
  vpc_id      = data.aws_vpc.cint.id
  tags        = merge(var.all_tags, { Name = var.sg_name })
}

resource "aws_security_group_rule" "ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  description       = "Connection from Clients"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_https" {
  security_group_id = aws_security_group.alb_sg.id
  description       = "Connection from Clients"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "cint_app" {
  name_prefix = var.appsg_name
  vpc_id      = data.aws_vpc.cint.id
  tags        = merge(var.all_tags, { Name = var.appsg_name })
}

resource "aws_security_group_rule" "cint_http" {
  security_group_id        = aws_security_group.cint_app.id
  description              = "Connection from ALB"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "cint_https" {
  security_group_id        = aws_security_group.cint_app.id
  description              = "Connection from ALB"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "cint_app_egress" {
  security_group_id = aws_security_group.cint_app.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "cint_db" {
  name_prefix = var.dbsg_name
  vpc_id      = data.aws_vpc.cint.id
  tags        = merge(var.all_tags, { Name = var.dbsg_name })
}
resource "aws_security_group_rule" "cintdb_http" {
  security_group_id        = aws_security_group.cint_db.id
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.cint_app.id
}

resource "aws_security_group_rule" "cintdb_egress" {
  security_group_id = aws_security_group.cint_db.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
