locals {
  project_domain = "${var.project_name}.${var.internal_domain}"
}

data "aws_ec2_transit_gateway" "tgw" {
  filter {
    name   = "options.auto-accept-shared-attachments"
    values = ["enable"]
  }
}

data "aws_organizations_organization" "org" {}

data "aws_route53_resolver_rule" "internal" {
  count = var.is_hub ? 0 : 1
  domain_name = "${var.internal_domain}"
  rule_type   = "FORWARD"
}

data "aws_route53_resolver_rule" "external" {
  count = var.is_hub ? 0 : 1
  name = "forward-outbound"
}
