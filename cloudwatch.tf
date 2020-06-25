
resource "aws_cloudwatch_event_permission" "OrganizationAccess" {
  count        = var.is_hub ? 1 : 0
  principal    = "*"
  statement_id = "OrganizationAccess"

  condition {
    key   = "aws:PrincipalOrgID"
    type  = "StringEquals"
    value = var.grace_dev_org_id
  }
}

resource "aws_cloudwatch_event_rule" "zone_association" {
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
  rule      = aws_cloudwatch_event_rule.zone_association.name
  target_id = "grace-management-account-eventbus"
  arn       = "arn:aws:events:us-east-1:${var.mgmt_dev_account}:event-bus/default"
}

resource "aws_cloudwatch_event_target" "lambda_trigger" {
  count     = var.is_hub ? 1 : 0
  rule      = aws_cloudwatch_event_rule.zone_association.name
  target_id = local.lambda_name
  arn       = aws_lambda_function.associate.arn
}