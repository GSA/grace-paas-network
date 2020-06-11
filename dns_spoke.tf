

# Configure the zone for this spoke
resource "aws_route53_zone" "spoke_internal" {
  count = var.is_hub ? 0 : 1
  name  = local.project_domain

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

resource "aws_route53_resolver_rule" "spoke_local" {
  count       = var.is_hub ? 0 : 1
  domain_name = local.project_domain
  name        = "resolve-local"
  rule_type   = "SYSTEM"
}

# associate external forwarding rule with all VPCs
resource "aws_route53_resolver_rule_association" "spoke_external" {
  count            = var.is_hub ? 0 : length(var.vpc_cidrblocks)
  resolver_rule_id = data.aws_route53_resolver_rule.external[0].resolver_rule_id
  vpc_id           = aws_vpc.self[count.index].id
}

# associate internal forwarding rule with all VPCs
resource "aws_route53_resolver_rule_association" "spoke_internal" {
  count            = var.is_hub ? 0 : length(var.vpc_cidrblocks)
  resolver_rule_id = data.aws_route53_resolver_rule.internal[0].resolver_rule_id
  vpc_id           = aws_vpc.self[count.index].id
}

# associate local system rule with all VPCs
resource "aws_route53_resolver_rule_association" "spoke_local" {
  count            = var.is_hub ? 0 : length(var.vpc_cidrblocks)
  resolver_rule_id = aws_route53_resolver_rule.spoke_local[0].id
  vpc_id           = aws_vpc.self[count.index].id
}
