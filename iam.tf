# Role for grace-paas-associate-zone Lambda function
resource "aws_iam_role" "lambda_role" {
  count       = var.is_hub ? 1 : 0
  name        = local.lambda_name
  description = "Role for GRACE PaaS Associate Zone Lambda function"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_policy" "lambda_policy" {
  count       = var.is_hub ? 1 : 0
  name        = local.lambda_name
  description = "Policy to allow associating VPC to hosted zone"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeVPCs",
        "route53:AssociateVPCWithHostedZone",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  count      = var.is_hub ? 1 : 0
  role       = aws_iam_role.lambda_role[0].name
  policy_arn = aws_iam_policy.lambda_policy[0].arn
}


# policy document for spoke account events:PutEvents on hub account Event Bus
data "aws_iam_policy_document" "put_events" {
  statement {
    effect = "Allow"
    actions = [
      "events:PutEvents"
    ]
    resources = [var.hub_account_bus_arn]
  }
}

data "aws_iam_policy_document" "put_events_assume" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

# role for put-events
resource "aws_iam_role" "put_events_role" {
  count              = var.is_hub ? 0 : 1
  name               = local.put_events
  description        = "Role for GRACE PaaS spoke access to put events on hub side Event Bus"
  assume_role_policy = data.aws_iam_policy_document.put_events_assume.json
}

resource "aws_iam_role_policy" "put_events_policy" {
  count  = var.is_hub ? 0 : 1
  name   = local.put_events
  role   = aws_iam_role.put_events_role[0].id
  policy = data.aws_iam_policy_document.put_events.json
}