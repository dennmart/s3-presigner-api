output "lambda_invoke_arn" {
  description = "The ARN to use for invoking the Lambda function"
  value       = aws_lambda_function.file_download_function.invoke_arn
}

output "lambda_source_code_hash" {
  description = "The hash of the source code of the Lambda function"
  value       = aws_lambda_function.file_download_function.source_code_hash
}
