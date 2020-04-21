variable "vpc_cidrblocks" {
  type        = list(string)
  description = "(required) List of VPC CIDR blocks, must be three"
}

variable "availability_zones" {
  type        = list(string)
  description = "(required) List of availaibility zones for VPC subnets"
}

variable "tgw_name" {
  type        = string
  description = "(required) Name of the Transit Gateway"
}
