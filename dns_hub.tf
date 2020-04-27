resource "aws_route53_zone" "hub_internal" {
  count = var.is_hub ? 1 : 0
  name  = var.internal_domain

  vpc {
    vpc_id = aws_vpc.self[0].id // frontend
  }

  vpc {
    vpc_id = aws_vpc.self[1].id // middle
  }

  vpc {
    vpc_id = aws_vpc.self[2].id // backend
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_ram_resource_share" "dns" {
  count                     = var.is_hub ? 1 : 0
  name                      = "dns"
  allow_external_principals = false
}

resource "aws_ram_resource_association" "external_rule" {
  count              = var.is_hub ? 1 : 0
  resource_arn       = aws_route53_resolver_rule.forward_external[0].arn
  resource_share_arn = aws_ram_resource_share.dns[0].arn
}

resource "aws_security_group" "dns" {
  count       = var.is_hub ? 1 : 0
  name        = "dns"
  description = "Allow 53 tcp/udp inbound to VPC"
  vpc_id      = aws_vpc.self[0].id // frontend

  ingress {
    description = "53/tcp from VPC"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS006
  }

  ingress {
    description = "53/udp from VPC"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  }
}

resource "aws_route53_resolver_endpoint" "internal" {
  count     = var.is_hub ? 1 : 0
  name      = "internal"
  direction = "INBOUND"

  security_group_ids = [aws_security_group.dns[0].id]

  ip_address {
    subnet_id = aws_subnet.self[0].id                      // frontend a-side
    ip        = cidrhost(aws_subnet.self[0].cidr_block, 4) // a-side cidr .4
  }

  ip_address {
    subnet_id = aws_subnet.self[1].id                      // frontend b-side
    ip        = cidrhost(aws_subnet.self[1].cidr_block, 4) // b-side cidr .4
  }
}

resource "aws_route53_resolver_endpoint" "external" {
  count     = var.is_hub ? 1 : 0
  name      = "external"
  direction = "OUTBOUND"

  security_group_ids = [aws_security_group.dns[0].id]

  ip_address {
    subnet_id = aws_subnet.self[0].id                      // frontend a-side
    ip        = cidrhost(aws_subnet.self[0].cidr_block, 5) // a-side cidr .5
  }

  ip_address {
    subnet_id = aws_subnet.self[1].id                      // frontend b-side
    ip        = cidrhost(aws_subnet.self[1].cidr_block, 5) // b-side cidr .5
  }
}

resource "aws_route53_resolver_rule" "hub_local" {
  count       = var.is_hub ? 1 : 0
  domain_name = var.internal_domain
  name        = "resolve-self"
  rule_type   = "SYSTEM"
}

resource "aws_route53_resolver_rule" "forward_external" {
  count                = var.is_hub ? 1 : 0
  domain_name          = var.external_domain
  name                 = "forward-outbound"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.external[0].id

  target_ip {
    ip = var.external_dns_server
  }
}


# Attach resolver rules to all VPCs in the hub

resource "aws_route53_resolver_rule_association" "hub_local" {
  count            = var.is_hub ? length(var.vpc_cidrblocks) : 0
  resolver_rule_id = aws_route53_resolver_rule.hub_local[0].id
  vpc_id           = aws_vpc.self[count.index].id
}

resource "aws_route53_resolver_rule_association" "hub_external" {
  count            = var.is_hub ? length(var.vpc_cidrblocks) : 0
  resolver_rule_id = aws_route53_resolver_rule.forward_external[0].id
  vpc_id           = aws_vpc.self[count.index].id
}
