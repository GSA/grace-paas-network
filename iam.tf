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
