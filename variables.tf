variable "vpc_cidrblocks" {
  type        = list(string)
  description = "(required) List of VPC CIDR blocks, must be three"
}

variable "availability_zones" {
  type        = list(string)
  description = "(required) List of availability zones for VPC subnets"
}

variable "internal_domain" {
  type        = string
  description = "(required) The domain name used internally for AWS name resolution"
}

variable "external_domain" {
  type        = string
  description = "(required) The domain name used externally for name resolution"
}

variable "external_dns_server" {
  type        = list(string)
  description = "(required) The IP addresses of the external DNS server"
}

variable "project_name" {
  type        = string
  description = "(required) The project name to be used when creating the subdomain for the spoke"
}

variable "appenv" {
  type        = string
  description = "(optional) The application environment"
  default     = "development"
}

variable "is_hub" {
  type        = bool
  description = "(optional) Indicates whether this account is the DNS Hub (default: false)"
  default     = false
}

variable "alb_cert_arn" {
  type        = string
  description = "(optional) ID of certificate in IAM role"
  default     = null
}

variable "load_balancer_type" {
  description = "Type of load balancer to provision (network or application)."
  type        = string
  default     = "application"
}

variable "internal" {
  description = "Provision an internal load balancer. Defaults to false."
  type        = bool
  default     = true
}

variable "hub_account_bus_arn" {
  description = "Hub account event bus ARN"
  type        = string
}

variable "org_id" {
  description = "GRACE AWS Org ID"
  type        = string
}

variable "lambda_source_file" {
  description = "(optional) Source file of Lambda function binary"
  type        = string
  default     = "../release/grace-paas-associate-zone.zip"
}

variable "hub_vpc_id" {
  description = "Hub account VPC for Hosted Zone Association"
  type        = string
}
