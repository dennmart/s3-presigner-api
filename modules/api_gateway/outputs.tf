output "apigw_url" {
  description = "The URL created for the API Gateway REST API to invoke the Lambda function"
  value       = aws_api_gateway_deployment.file_download_gateway_deployment.invoke_url
}

output "apigw_api_key" {
  description = "The API key created for the API Gateway REST API and deployed stage"
  value       = aws_api_gateway_api_key.file_download_api_key.value
  sensitive   = true
}

output "apigw_id" {
  description = "The ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.file_download_rest_api.id
}
