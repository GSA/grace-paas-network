
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
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  ingress {
    description = "dns"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
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

    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
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
