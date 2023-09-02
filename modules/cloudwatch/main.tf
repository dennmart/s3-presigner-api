resource "aws_cloudwatch_log_group" "apigw_log_group" {
  name              = var.apigw_log_group_name
  retention_in_days = var.apigw_log_group_retention
}
