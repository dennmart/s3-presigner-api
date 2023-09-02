output "apigw_log_group_arn" {
  description = "The ARN of the CloudWatch log group for API Gateway"
  value       = aws_cloudwatch_log_group.apigw_log_group.arn
}
