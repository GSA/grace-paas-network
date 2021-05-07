terraform {
  required_providers {
    aws = {
      # TF-UPGRADE-TODO
      #
      # No source detected for this provider. You must add a source address
      # in the following format:
      #
      # source = "your-registry.example.com/organization/aws"
      #
      # For more information, see the provider source documentation:
      #
      # https://www.terraform.io/docs/configuration/providers.html#provider-source
    }
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.13"
}
