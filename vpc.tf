resource "aws_vpc" "self" {
  count                = length(var.vpc_cidrblocks)
  cidr_block           = var.vpc_cidrblocks[count.index]
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

resource "aws_vpc_peering_connection" "front_mid" {
  peer_vpc_id = aws_vpc.self[0].id
  vpc_id      = aws_vpc.self[1].id
  auto_accept = true
}

resource "aws_vpc_peering_connection" "mid_back" {
  peer_vpc_id = aws_vpc.self[1].id
  vpc_id      = aws_vpc.self[2].id
  auto_accept = true
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  count              = length(var.vpc_cidrblocks)
  subnet_ids         = [aws_subnet.self[count.index * 2].id, aws_subnet.self[(count.index * 2) + 1].id]
  transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.self[count.index].id
}

resource "aws_vpc_dhcp_options" "options" {
  count       = length(var.vpc_cidrblocks)
  domain_name = local.project_domain
  domain_name_servers = [
    cidrhost(aws_subnet.self[count.index * 2].cidr_block, 2),
    cidrhost(aws_subnet.self[(count.index * 2) + 1].cidr_block, 2)
  ]
}

resource "aws_vpc_dhcp_options_association" "options" {
  count           = length(var.vpc_cidrblocks)
  vpc_id          = aws_vpc.self[count.index].id
  dhcp_options_id = aws_vpc_dhcp_options.options[count.index].id
}

resource "aws_flow_log" "flow" {
  count                = length(var.vpc_cidrblocks)
  log_destination      = var.flow_log_destination
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.self[count.index].id
}
