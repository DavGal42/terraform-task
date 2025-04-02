resource "aws_lambda_function" "lambda_s3" {
  function_name = "lambda_s3"
  role          = aws_iam_role.lambda_s3_role.arn
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  filename      = "${path.module}/lambda_s3.zip"
}

resource "aws_lambda_function" "lambda_dynamo" {
  function_name = "lambda_dynamo"
  role          = aws_iam_role.lambda_dynamo_role.arn
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  filename      = "${path.module}/lambda_dynamo.zip"
}


resource "aws_iam_role" "lambda_s3_role" {
  name = "TestLambdaS3Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_s3_policy" {
  name   = "LambdaS3Policy"
  role   = aws_iam_role.lambda_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "lambda_dynamo_role" {
  name = "TestLambdaDynamoRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "lambda_dynamo_policy" {
  name   = "LambdaDynamoPolicy"
  role   = aws_iam_role.lambda_dynamo_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["dynamodb:Scan"]
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

resource "aws_lambda_permission" "lambda_s3_permission" {
  statement_id  = "AllowAPIGatewayInvokeLambdaS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_s3.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.api_gateway_id}/*/*/*"
}

resource "aws_lambda_permission" "lambda_dynamo_permission" {
  statement_id  = "AllowAPIGatewayInvokeLambdaDynamo"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dynamo.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.api_gateway_id}/*/*/*"
}
