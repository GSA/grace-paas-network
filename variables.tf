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
  type        = string
  description = "(required) The IP Address of the external DNS server"
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
