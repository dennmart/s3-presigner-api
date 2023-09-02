variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role to attach to the Lambda function"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket containing the private object"
  type        = string
}

variable "s3_object" {
  description = "The name of the private S3 object"
  type        = string
}
