# aws-lambda-ml-inference-deploy

이 프로젝트는 AWS Lambda를 사용하여 Docker 컨테이너 형태로 머신러닝 예측 모델을 배포하는 과정을 자동화합니다. 
아래의 단계에 따라 필요한 환경을 설정하고, Docker 이미지를 빌드 및 배포할 수 있습니다.

## 사전 준비 사항
* AWS 계정
* Docker 설치
* AWS CLI 설치 및 구성
* AWS ECR 레포지토리 생성

## 진행 과정

1) 모델은 AWS S3로부터 가져오고, Lambda 함수에서는 해당 모델을 가져오는 과정을 진행합니다. \
이를 위해 AWS S3에 모델을 저장하고 변수 값을 설정해줍니다.

```
vi lambda_function.py

def lambda_handler(event, context):
    # S3 버킷과 모델 파일 정보
    bucket_name = ''
    object_key = '.pth'
    download_path = '/tmp/.pth'
```
object_key = 모델 이름 \
download_path = '/tmp/모델 이름' 


```
vi env.sh

export IMAGE_NAME="image name"
export ECR_NAME="ecr-name"
export AWS_ACCOUNT_ID="123456789012"
export AWS_REGION="ap-northeast-2"
```

IMAGE_NAME = 설정할 이미지 이름 \
ECR_NAME = AWS ECR 이름 \
AWS_ACCOUNT_ID = ECR URI 앞에 포함된 ID \
AWS_REGION = 서울 기준 ap-northeast-2 

2) AWS CLI 구성
```
aws configure
```

3) 환경 변수 설정
```
chmod +x env.sh
./env.sh
```

4) 도커 이미지 빌드 및 ecr 푸시
```
chmod +x build.sh
./build.sh
```


