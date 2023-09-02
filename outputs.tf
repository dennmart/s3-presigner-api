output "api_url" {
  value = "${module.api_gateway.apigw_url}${local.apigw_api_stage_name}/${local.apigw_resource_path_part}"
}

output "api_key" {
  value     = module.api_gateway.apigw_api_key
  sensitive = true
}
