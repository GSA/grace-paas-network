locals {
  project_domain = "${var.project_name}.${var.internal_domain}"
}

data "aws_ec2_transit_gateway" "tgw" {
  filter {
    name   = "options.auto-accept-shared-attachments"
    values = ["enable"]
  }
}
