output "lambda_s3_arn" {
  value = aws_lambda_function.lambda_s3.invoke_arn
}

output "lambda_dynamo_arn" {
  value = aws_lambda_function.lambda_dynamo.invoke_arn
}