data "aws_ram_resource_share" "tgw" {
  name           = var.tgw_name
  resource_owner = "OTHER-ACCOUNTS"
}

