import boto3
import torch
import torch.nn as nn
import json

class SimpleModel(nn.Module):
    def __init__(self):
        super(SimpleModel, self).__init__()
        self.linear = nn.Linear(10, 1)
    def forward(self, x):
        return self.linear(x)

def download_model_from_s3(bucket_name, object_key, download_path):
    s3 = boto3.client('s3')
    s3.download_file(bucket_name, object_key, download_path)

def load_model(model_path):
    model = SimpleModel()
    model.load_state_dict(torch.load(model_path, map_location=torch.device('cpu')))
    model.eval()
    return model

def lambda_handler(event, context):
    # S3 버킷과 모델 파일 정보
    bucket_name = ''
    object_key = '.pth'
    download_path = '/tmp/.pth'  

    download_model_from_s3(bucket_name, object_key, download_path)

    model = load_model(download_path)

    return {
        'statusCode': 200,
        'headers': { "content-type" : "application/json; charset=utf-8"},
        'body': json.dumps({'message': 'Model loaded successfully'})
    }
