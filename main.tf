module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}

module "dynamodb" {
  source              = "./modules/dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}

module "lambda" {
  source              = "./modules/lambda"
  s3_bucket_name      = var.s3_bucket_name
  dynamodb_table_name = var.dynamodb_table_name
  region              = var.region
  api_gateway_id = module.api_gateway.api_gateway_id
}

module "api_gateway" {
  source        = "./modules/api_gateway"
  lambda_s3     = module.lambda.lambda_s3_arn
  lambda_dynamo = module.lambda.lambda_dynamo_arn
  region = var.region
}