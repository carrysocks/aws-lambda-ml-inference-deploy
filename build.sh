#!/bin/bash

IMAGE_NAME=${IMAGE_NAME:-"image_name"}
ECR_NAME=${ECR_NAME:-"image_name"}
AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID:-"123456789012"}
AWS_REGION=${AWS_REGION:-"ap-northeast-2"}

echo "Uploading docker image to ECR..."

docker build -t $IMAGE_NAME .

docker tag $IMAGE_NAME $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_NAME

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_NAME

echo "Finish uploading docker image to ECR"
