variable "s3_bucket_name" {
  description = "The name of the S3 bucket containing the private file"
  type        = string
}

variable "s3_object" {
  description = "The name of the private S3 object"
  type        = string
}

variable "role_name" {
  description = "The name of the role for Lambda to access the private S3 object and API Gateway to write logs to CloudWatch"
  type        = string
}

variable "role_policy_name" {
  description = "The name of the policy to attach to the Lambda/API Gateway role"
  type        = string
}
