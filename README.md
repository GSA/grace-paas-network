# <a name="top">GRACE PaaS Network</a> [![CircleCI](https://circleci.com/gh/GSA/grace-paas-network.svg?style=svg&circle-token=d0bdc1c9e646280312a4a8254f7c8d4698c8729f)](https://circleci.com/gh/GSA/grace-paas-network)

The GRACE PaaS Network module creates the the network resources required for a basic GRACE PaaS account.

## Table of Contents

- [Repository contents](#repository-contents)
- [Usage](#usage)
- [Terraform Module Inputs](#terraform-module-inputs)
- [Terraform Module Outputs](#terraform-module-outputs)

[top](#top)

## Repository contents

- **main.tf** contains the data resource for the Transit Gateway RAM shared resource
- **vpc.tf** contains the resource for the Front, Mid, and Back VPCs, peering connections, and transit gateway connections
- **route.tf** contains the route tables and route resources
- **subnet.tf** contains the subnets for the VPCs
- **dns_hub.tf** contains configuration details for DNS resolvers and shared forwarding rules
- **dns_spoke.tf** contains the configuration details for customer side DNS setup
- **variables.tf** contains all configurable variables
- **outputs.tf** contains all Terraform output variables
- **internal_security_groups.tf** contains GRACE standard Service Security Groups and Network Security Groups


[top](#top)

# Usage

Simply import grace-paas-vpc as a module into your Terraform for the destination AWS Environment.

```
module "network" {
    source                    = "github.com/GSA/grace-paas-network?ref=v0.0.1"
    cloudtrail_log_group_name = "<log_group_name>"
    recipient                 = "<email_address>"
}
```

[top](#top)

## Terraform Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | (required) List of availability zones for VPC subnets | `list(string)` | n/a | yes |
| tgw\_name | (optional) Name of the Transit Gateway | `string` | `gsa-tgw-prod-v1` | no |
| vpc\_cidrblocks | (required) List of VPC CIDR blocks, must be three | `list(string)` | n/a | yes |
| ingress_rules | (optional) List of ingress rules for shared services security group | `list(map(string))` | n/a | no |

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

[top](#top)

## Terraform Module Outputs

| Name | Description |
|------|-------------|
| back\_rt\_id | Back VPC route table ID |
| back\_vpc\_cidr | Back VPC CIDR block |
| back\_vpc\_id | Back VPC ID |
| back\_vpc\_subnet\_cidr\_blocks | Back VPC subnet CIDR blocks |
| back\_vpc\_subnet\_ids | Back VPC subnet IDs |
| front\_mid\_peering\_connection\_id | Front to mid VPC peering connection ID |
| front\_rt\_id | Front VPC route table ID |
| front\_vpc\_cidr | Front VPC CIDR block |
| front\_vpc\_id | Front VPC ID |
| front\_vpc\_subnet\_cidr\_blocks | Front VPC subnet CIDR blocks |
| front\_vpc\_subnet\_ids | Front VPC subnet IDs |
| mid\_back\_peering\_connection\_id | Mid to back VPC peering connection ID |
| mid\_rt\_id | Mid VPC route table ID |
| mid\_vpc\_cidr | Mid VPC CIDR block |
| mid\_vpc\_id | Mid VPC ID |
| mid\_vpc\_subnet\_cidr\_blocks | Mid VPC subnet CIDR blocks |
| mid\_vpc\_subnet\_ids | Mid VPC subnet IDs |
|shared\_srvs\_sg\_id | Shared Services Security Group ids |

[top](#top)

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.

[top](#top)
