
resource "aws_security_group" "nw_sec_sg" {
  count       = length(aws_vpc.self)
  name        = "nw_sg-${count.index}"
  description = "GRACE Shared Network and Security Group"
  vpc_id      = aws_vpc.self[count.index].id

  ingress {
    description = "dns"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "dns"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Network_Securty_SG-${count.index}"
  }


}


resource "aws_security_group" "shared_srvs_sg" {
  count       = length(aws_vpc.self)
  name        = "shared_srvs_sg-${count.index}"
  description = "GRACE Shared Services Security Group"
  vpc_id      = aws_vpc.self[count.index].id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Shared_Services_SG-${count.index}"
  }

}

resource "aws_security_group_rule" "vra_rule01" {
  count             = length(aws_vpc.self)
  security_group_id = aws_security_group.shared_srvs_sg[count.index].id
  cidr_blocks       = ["159.142.0.0/16"]
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  description       = "VRA HTTPS Port Group"

}

resource "aws_security_group_rule" "vra_rule02" {
  count             = length(aws_vpc.self)
  security_group_id = aws_security_group.shared_srvs_sg[count.index].id
  cidr_blocks       = ["192.168.101.128/26"]
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  description       = "VRA HTTPS Port Group"

}
