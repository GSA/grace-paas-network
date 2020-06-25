
resource "aws_cloudwatch_event_permission" "OrganizationAccess" {
  count        = var.is_hub ? 1 : 0
  principal    = "*"
  statement_id = "OrganizationAccess"

  condition {
    key   = "aws:PrincipalOrgID"
    type  = "StringEquals"
    value = var.org_id
  }
}

resource "aws_cloudwatch_event_rule" "zone_association" {
  count         = var.is_hub ? 0 : 1
  name          = "hosted-zone-association-events"
  description   = "Capture hosted zone VPC association authorizations"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.route53"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "route53.amazonaws.com"
    ],
    "eventName": [
      "CreateVPCAssociationAuthorization"
    ]
  }
}
PATTERN

}

resource "aws_cloudwatch_event_target" "grace-mgmt-event" {
  count     = var.is_hub ? 0 : 1
  rule      = aws_cloudwatch_event_rule.zone_association[0].name
  target_id = "grace-management-account-eventbus"
  arn       = var.hub_account_bus_arn
}
