resource "aws_lambda_function" "associate" {
  filename      = var.lambda_source_file
  function_name = local.lambda_name
  description   = "Associates tenant VPC with Route53 hosted zone when triggered by Cloudwatch event"
  role          = aws_iam_role.lambda_role.arn
}
