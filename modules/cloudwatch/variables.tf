variable "apigw_log_group_name" {
  description = "The name of the CloudWatch log group to create for API Gateway"
  type        = string
}

variable "apigw_log_group_retention" {
  description = "The number of days to retain logs in the API Gateway log group"
  type        = number
  default     = 7
}
