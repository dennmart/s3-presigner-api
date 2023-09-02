data "archive_file" "file_download_function" {
  type        = "zip"
  source_dir  = "${path.module}/../../functions/s3_presign_url"
  output_path = "${path.module}/../../functions/tmp/s3_presign_url.zip"
}

resource "aws_lambda_function" "file_download_function" {
  filename         = data.archive_file.file_download_function.output_path
  function_name    = var.function_name
  role             = var.role_arn
  handler          = "function.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.file_download_function.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = var.s3_bucket_name
      OBJECT_KEY  = var.s3_object
    }
  }
}

resource "aws_lambda_permission" "api_gateway_lambda_invoke_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.file_download_function.function_name
  principal     = "apigateway.amazonaws.com"
}
