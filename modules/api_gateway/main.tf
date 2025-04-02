resource "aws_api_gateway_rest_api" "api" {
  name        = "MyAPI"
  description = "API Gateway with two routes"
}

resource "aws_api_gateway_resource" "resource_1" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "1"
}

resource "aws_api_gateway_resource" "resource_2" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "2"
}

resource "aws_api_gateway_method" "method_1" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_1.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "method_2" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_2.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_1" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_1.id
  http_method             = aws_api_gateway_method.method_1.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_s3
}

resource "aws_api_gateway_integration" "integration_2" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_2.id
  http_method             = aws_api_gateway_method.method_2.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_dynamo
}


resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.integration_1, aws_api_gateway_integration.integration_2]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}