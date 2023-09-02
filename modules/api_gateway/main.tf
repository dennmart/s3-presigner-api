resource "aws_api_gateway_rest_api" "file_download_rest_api" {
  name = var.rest_api_name
}

resource "aws_api_gateway_resource" "file_download_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.file_download_rest_api.id
  parent_id   = aws_api_gateway_rest_api.file_download_rest_api.root_resource_id
  path_part   = var.resource_path_part
}

resource "aws_api_gateway_method" "file_download_gateway_method" {
  rest_api_id      = aws_api_gateway_rest_api.file_download_rest_api.id
  resource_id      = aws_api_gateway_resource.file_download_gateway_resource.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "file_download_gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.file_download_rest_api.id
  resource_id = aws_api_gateway_resource.file_download_gateway_resource.id
  http_method = aws_api_gateway_method.file_download_gateway_method.http_method

  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "file_download_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.file_download_rest_api.id

  depends_on = [aws_api_gateway_integration.file_download_gateway_integration]

  triggers = {
    redeployment = sha1(jsonencode([
      var.lambda_source_code_hash,
      aws_api_gateway_rest_api.file_download_rest_api
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "file_download_gateway_stage" {
  stage_name    = var.api_stage_name
  rest_api_id   = aws_api_gateway_rest_api.file_download_rest_api.id
  deployment_id = aws_api_gateway_deployment.file_download_gateway_deployment.id

  access_log_settings {
    destination_arn = var.apigw_log_group_arn

    format = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }
}

resource "aws_api_gateway_api_key" "file_download_api_key" {
  name = var.api_key_name
}

resource "aws_api_gateway_usage_plan" "file_download_usage_plan" {
  name = var.usage_plan_name

  api_stages {
    api_id = aws_api_gateway_rest_api.file_download_rest_api.id
    stage  = aws_api_gateway_stage.file_download_gateway_stage.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "file_download_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.file_download_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.file_download_usage_plan.id
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = var.apigw_cloudwatch_role_arn
}
