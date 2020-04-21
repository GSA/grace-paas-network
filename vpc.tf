resource "aws_vpc" "self" {
  for_each             = var.vpc_cidrblocks
  cidr_block           = each.value
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

resource "aws_vpc_peering_connection" "front_mid" {
  peer_vpc_id = aws_vpc.self[0].id
  vpc_id      = aws_vpc.self[1].id
}

resource "aws_vpc_peering_connection" "mid_back" {
  peer_vpc_id = aws_vpc.self[1].id
  vpc_id      = aws_vpc.self[2].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  count              = length(var.vpc_cidrblocks)
  subnet_ids         = [aws_subnet.self[count.index * 2].id, aws_subnet.self[(count.index * 2) + 1].id]
  transit_gateway_id = data.aws_ram_resource_share.tgw.id
  vpc_id             = aws_vpc.self[count.index].id
}
