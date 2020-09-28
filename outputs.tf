output "frontend_vpc_id" {
  value       = aws_vpc.self[0].id
  description = "Frontend VPC ID"
}

output "middleware_vpc_id" {
  value       = aws_vpc.self[1].id
  description = "Middleware VPC ID"
}

output "backend_vpc_id" {
  value       = aws_vpc.self[2].id
  description = "Backend VPC ID"
}

output "vpc_ids" {
  value       = [aws_vpc.self[0].id, aws_vpc.self[1].id, aws_vpc.self[2].id]
  description = "VPC IDs for Frontend Middleware and Backend"
}

output "frontend_vpc_cidr" {
  value       = aws_vpc.self[0].cidr_block
  description = "Frontend VPC CIDR block"
}

output "middleware_vpc_cidr" {
  value       = aws_vpc.self[1].cidr_block
  description = "Middleware VPC CIDR block"
}

output "backend_vpc_cidr" {
  value       = aws_vpc.self[2].cidr_block
  description = "Backend VPC CIDR block"
}

output "frontend_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[0].cidr_block, aws_subnet.self[1].cidr_block]
  description = "Frontend VPC subnet CIDR blocks"
}

output "middleware_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[2].cidr_block, aws_subnet.self[3].cidr_block]
  description = "Middleware VPC subnet CIDR blocks"
}

output "backend_vpc_subnet_cidr_blocks" {
  value       = [aws_subnet.self[4].cidr_block, aws_subnet.self[5].cidr_block]
  description = "Backend VPC subnet CIDR blocks"
}

output "frontend_vpc_subnet_ids" {
  value       = [aws_subnet.self[0].id, aws_subnet.self[1].id]
  description = "Frontend VPC subnet IDs"
}

output "middleware_vpc_subnet_ids" {
  value       = [aws_subnet.self[2].id, aws_subnet.self[3].id]
  description = "Middleware VPC subnet IDs"
}

output "backend_vpc_subnet_ids" {
  value       = [aws_subnet.self[4].id, aws_subnet.self[5].id]
  description = "Backend VPC subnet IDs"
}

output "frontend_middleware_peering_connection_id" {
  value       = aws_vpc_peering_connection.front_mid.id
  description = "Frontend to middleware VPC peering connection ID"
}

output "middleware_backend_peering_connection_id" {
  value       = aws_vpc_peering_connection.mid_back.id
  description = "Middleware to backend VPC peering connection ID"
}

output "frontend_rt_id" {
  value       = aws_default_route_table.front.id
  description = "Frontend VPC route table ID"
}

output "middleware_rt_id" {
  value       = aws_default_route_table.mid.id
  description = "Middleware VPC route table ID"
}

output "backend_rt_id" {
  value       = aws_default_route_table.back.id
  description = "Backend VPC route table ID"
}

output "shared_srvs_sg_ids" {
  value       = aws_security_group.shared_srvs_sg[*].id
  description = "ouput all the new security groups"
}

output "zone_id" {
  value       = local.zone_id
  description = "output for the route53 zone id"
}

output "project_domain" {
  value       = local.project_domain
  description = "output for the domain for the project"
}

output "frontend_subnet_az0" {
  value       = aws_subnet.self[0].id
  description = "Frontend subnet in first AZ"
}

output "frontend_subnet_az1" {
  value       = aws_subnet.self[1].id
  description = "Frontend subnet in second AZ"
}

output "frontend_sg_ids" {
  value       = [aws_security_group.shared_srvs_sg[0].id]
  description = "Frontend security group IDs"
}

output "middleware_subnet_az0" {
  value       = aws_subnet.self[2].id
  description = "Middleware subnet in first AZ"
}

output "middleware_subnet_az1" {
  value       = aws_subnet.self[3].id
  description = "Middleware subnet in second AZ"
}

output "middleware_sg_ids" {
  value       = [aws_security_group.shared_srvs_sg[1].id]
  description = "Middleware security group IDs"
}

output "backend_subnet_az0" {
  value       = aws_subnet.self[4].id
  description = "Backend subnet in first AZ"
}

output "backend_subnet_az1" {
  value       = aws_subnet.self[5].id
  description = "Backend subnet in second AZ"
}

output "backend_sg_ids" {
  value       = [aws_security_group.shared_srvs_sg[2].id]
  description = "Backend security group IDs"
}
