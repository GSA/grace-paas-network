resource "aws_lambda_function" "associate" {
  count            = var.is_hub ? 1 : 0
  filename         = var.lambda_source_file
  function_name    = local.lambda_name
  description      = "Associates tenant VPC with Route53 hosted zone when triggered by Cloudwatch event"
  role             = aws_iam_role.lambda_role[0].arn
  handler          = "grace-inventory-lambda"
  source_code_hash = filesha256(var.lambda_source_file)
  runtime          = "go1.x"
}

resource "aws_lambda_permission" "event" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.associate[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.zone_association.arn
}
