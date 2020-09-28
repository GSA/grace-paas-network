resource "aws_security_group" "shared_srvs_sg" {
  count       = length(aws_vpc.self)
  name        = "shared_srvs_sg-${count.index}"
  description = "GRACE Shared Services Security Group"
  vpc_id      = aws_vpc.self[count.index].id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value["description"]
      from_port = ingress.value["from_port"]
      to_port = ingress.value["to_port"]
      cidr_blocks = ingress.value["cidr_blocks"]
      protocol = ingress.value["protocol"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = {
    Name = "Shared_Services_SG-${count.index}"
  }

}
