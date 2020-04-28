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
  domain_name = "${var.internal_domain}"
}

data "aws_route53_resolver_rule" "external" {
  domain_name = "${var.external_domain}"
}
