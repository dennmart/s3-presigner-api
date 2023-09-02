output "role_arn" {
  description = "The ARN of the role for Lambda to access the private S3 object and API Gateway to write logs to CloudWatch"
  value       = aws_iam_role.role.arn
}
