terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14.0"
    }
  }
}

locals {
  s3_bucket_name           = "dennmart-private-bucket"
  s3_object                = "my-private-object.txt"
  apigw_api_stage_name     = "prod"
  apigw_resource_path_part = "download"
}

module "iam" {
  source = "./modules/iam"

  s3_bucket_name   = local.s3_bucket_name
  s3_object        = local.s3_object
  role_name        = "S3PresignerAPIRole"
  role_policy_name = "S3PresignerAPIRolePolicy"
}

module "lambda" {
  source = "./modules/lambda"

  s3_bucket_name = local.s3_bucket_name
  s3_object      = local.s3_object
  function_name  = "S3PresignerAPIFunction"
  role_arn       = module.iam.role_arn
}

module "api_gateway" {
  source = "./modules/api_gateway"

  rest_api_name             = "S3PresignerAPI"
  resource_path_part        = local.apigw_resource_path_part
  lambda_source_code_hash   = module.lambda.lambda_source_code_hash
  lambda_invoke_arn         = module.lambda.lambda_invoke_arn
  api_stage_name            = local.apigw_api_stage_name
  api_key_name              = "S3PresignerAPIKey"
  usage_plan_name           = "S3PresignerAPIUsagePlan"
  apigw_cloudwatch_role_arn = module.iam.role_arn
  apigw_log_group_arn       = module.cloudwatch.apigw_log_group_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  apigw_log_group_name = "/aws/api-gateway/${module.api_gateway.apigw_id}"
}
