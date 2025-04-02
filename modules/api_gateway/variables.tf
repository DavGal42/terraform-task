variable "lambda_s3" {
  description = "ARN of Lambda_S3 function"
  type        = string
}

variable "lambda_dynamo" {
  description = "ARN of Lambda_Dynamo function"
  type        = string
}

variable "region" {
  default = "us-west-2"
}