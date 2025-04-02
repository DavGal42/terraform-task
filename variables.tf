variable "region" {
  default = "us-west-2"
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket"
  default = "testbucketfromdavidgalstyan"
}

variable "dynamodb_table_name" {
  description = "Name of DynamoDB table"
  default = "MyTable"
}