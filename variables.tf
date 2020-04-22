variable "vpc_cidrblocks" {
  type        = list(string)
  description = "(required) List of VPC CIDR blocks, must be three"
}

variable "availability_zones" {
  type        = list(string)
  description = "(required) List of availability zones for VPC subnets"
}

variable "tgw_name" {
  type        = string
  description = "(optional) Name of the Transit Gateway"
  default     = "gsa-tgw-prod-v1"
}
