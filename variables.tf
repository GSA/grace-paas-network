variable "vpc_cidrblocks" {
  type        = list(string)
  description = "(required) List of VPC CIDR blocks, must be three"
}

variable "availability_zones" {
  type        = list(string)
  description = "(required) List of availability zones for VPC subnets"
}

variable "tgw_id" {
  type        = string
  description = "(optional) ID of the Transit Gateway"
  default     = "tgw-0a5a3a1935972e4f0"
}

variable "alb_cert_arn" {
  type        = string
  description = "(optional) ID of certificate in IAM role"
  default     = null
}
