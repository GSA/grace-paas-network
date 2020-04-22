resource "aws_default_route_table" "front" {
  default_route_table_id = aws_vpc.self[0].default_route_table_id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.tgw_id
  }

  route {
    cidr_block                = aws_vpc.self[1].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.front_mid.id
  }

}

resource "aws_default_route_table" "mid" {
  default_route_table_id = aws_vpc.self[1].default_route_table_id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.tgw_id
  }

  route {
    cidr_block                = aws_vpc.self[0].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.front_mid.id
  }

  route {
    cidr_block                = aws_vpc.self[2].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.mid_back.id
  }

}

resource "aws_default_route_table" "back" {
  default_route_table_id = aws_vpc.self[2].default_route_table_id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.tgw_id
  }

  route {
    cidr_block                = aws_vpc.self[1].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.mid_back.id
  }

}
