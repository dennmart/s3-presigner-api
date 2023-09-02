variable "rest_api_name" {
  description = "The name of the API Gateway REST API"
  type        = string
}

variable "resource_path_part" {
  description = "The path part of the API Gateway resource which is appended to the REST API endpoint"
  type        = string
}

variable "lambda_source_code_hash" {
  description = "The base64-encoded SHA256 hash of the Lambda function source code"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The ARN to invoke the Lambda function from the API Gateway resource"
  type        = string
}

variable "api_stage_name" {
  description = "The name of the API Gateway stage for deployment"
  type        = string
}

variable "api_key_name" {
  description = "The name of the API key to use for the API Gateway REST API and deployed stage"
  type        = string
}

variable "usage_plan_name" {
  description = "The name of the usage plan to use for the API Gateway REST API"
  type        = string
}

variable "apigw_cloudwatch_role_arn" {
  description = "The ARN of the IAM role to use for API Gateway CloudWatch logging"
  type        = string
}

variable "apigw_log_group_arn" {
  description = "The ARN of the API Gateway CloudWatch log group"
  type        = string
}
