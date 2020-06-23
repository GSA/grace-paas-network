output "front_vpc_id" {
  value       = aws_vpc.self[0].id
  description = "Front VPC ID"
}

output "mid_vpc_id" {
  value       = aws_vpc.self[1].id
  description = "Mid VPC ID"
}

output "back_vpc_id" {
  value       = aws_vpc.self[2].id
  description = "Back VPC ID"
}

output "vpc_ids" {
  value       = [aws_vpc.self[0].id, aws_vpc.self[1].id, aws_vpc.self[2].id]
  description = "VPC IDs for Front Mid and Back"
}

output "front_vpc_cidr" {
  value       = aws_vpc.self[0].cidr_block
  description = "Front VPC CIDR block"
}

output "mid_vpc_cidr" {
  value       = aws_vpc.self[1].cidr_block
  description = "Mid VPC CIDR block"
}

output "back_vpc_cidr" {
  value       = aws_vpc.self[2].cidr_block
  description = "Back VPC CIDR block"
}

output "front_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[0].cidr_block, aws_subnet.self[1].cidr_block]
  description = "Front VPC subnet CIDR blocks"
}

output "mid_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[2].cidr_block, aws_subnet.self[3].cidr_block]
  description = "Mid VPC subnet CIDR blocks"
}

output "back_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[4].cidr_block, aws_subnet.self[5].cidr_block]
  description = "Back VPC subnet CIDR blocks"
}

output "front_vpc_subnet_ids" {
  value       = [aws_subnet.self[0].id, aws_subnet.self[1].id]
  description = "Front VPC subnet IDs"
}

output "mid_vpc_subnet_ids" {
  value       = [aws_subnet.self[2].id, aws_subnet.self[3].id]
  description = "Mid VPC subnet IDs"
}

output "back_vpc_subnet_ids" {
  value       = [aws_subnet.self[4].id, aws_subnet.self[5].id]
  description = "Back VPC subnet IDs"
}

output "front_mid_peering_connection_id" {
  value       = aws_vpc_peering_connection.front_mid.id
  description = "Front to mid VPC peering connection ID"
}

output "mid_back_peering_connection_id" {
  value       = aws_vpc_peering_connection.mid_back.id
  description = "Mid to back VPC peering connection ID"
}

output "front_rt_id" {
  value       = aws_default_route_table.front.id
  description = "Front VPC route table ID"
}

output "mid_rt_id" {
  value       = aws_default_route_table.mid.id
  description = "Mid VPC route table ID"
}

output "back_rt_id" {
  value       = aws_default_route_table.back.id
  description = "Back VPC route table ID"
}

output "nw_sg_ids" {
  value       = aws_security_group.nw_sec_sg[*].id
  description = "ouput all the new security gropus"
}

output "shared_srvs_sg_ids" {
  value       = aws_security_group.shared_srvs_sg[*].id
  description = "ouput all the new security gropus"
}
