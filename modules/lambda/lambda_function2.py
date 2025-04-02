import json
import boto3
import os

dynamodb = boto3.client('dynamodb')
TABLE_NAME = os.getenv('TABLE_NAME', 'MyTable')

def lambda_handler(event, context):
    response = dynamodb.scan(TableName=TABLE_NAME)
    return {"statusCode": 200, "body": json.dumps(response["Items"])}