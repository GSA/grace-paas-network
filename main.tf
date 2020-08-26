locals {
  // if we're the hub then we're using internal_domain, otherwise prepend the customer project name
  env_id         = var.appenv == "production" ? "" : "-" + substr(var.appenv, 0, 1)
  project_domain = var.is_hub ? var.internal_domain : "${var.project_name}${local.env_id}.${var.internal_domain}"
  lambda_name    = "grace-paas-associate-zone"
  put_events     = "put-events"
  zone_id        = var.is_hub ? aws_route53_zone.hub_internal[0].id : aws_route53_zone.spoke_internal[0].id
}

data "aws_ec2_transit_gateway" "tgw" {
  filter {
    name   = "options.auto-accept-shared-attachments"
    values = ["enable"]
  }
}

data "aws_organizations_organization" "org" {}

data "aws_route53_resolver_rule" "internal" {
  count       = var.is_hub ? 0 : 1
  domain_name = "${var.internal_domain}"
  rule_type   = "FORWARD"
}

data "aws_route53_resolver_rule" "external" {
  count = var.is_hub ? 0 : 1
  name  = "forward-outbound"
}

data "aws_region" "current" {
}
