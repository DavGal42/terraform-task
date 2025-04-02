import json
import boto3
import os

s3 = boto3.client('s3')
BUCKET_NAME = os.getenv('BUCKET_NAME', 'testbucketfromdavidgalstyan')

def lambda_handler(event, context):
    action = event.get("queryStringParameters", {}).get("action", "list")
    
    if action == "put":
        s3.put_object(Bucket=BUCKET_NAME, Key="test.txt", Body="Hello, S3!")
        return {"statusCode": 200, "body": json.dumps("File uploaded")}
    
    elif action == "get":
        obj = s3.get_object(Bucket=BUCKET_NAME, Key="test.txt")
        content = obj['Body'].read().decode('utf-8')
        return {"statusCode": 200, "body": json.dumps(content)}
    
    else:
        objects = s3.list_objects_v2(Bucket=BUCKET_NAME).get("Contents", [])
        return {"statusCode": 200, "body": json.dumps([obj["Key"] for obj in objects])}