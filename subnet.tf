resource "aws_subnet" "self" {
  count             = len(var.vpc_cidrblocks) * 2
  vpc_id            = aws_vpc.self[floor(count.index / 2)].id
  cidr_block        = cidrsubnet(aws_vpc.self[floor(count.index / 2)].cidr_block, 2, count.index % 2)
  availability_zone = var.availability_zones[count.index % 2]
}

