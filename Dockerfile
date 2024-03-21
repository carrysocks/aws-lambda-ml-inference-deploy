FROM amazon/aws-lambda-python:3.8

RUN /var/lang/bin/python3.8 -m pip install --upgrade pip

RUN yum install git -y

COPY requirements.txt /var/task
RUN pip install -r requirements.txt

COPY lambda_function.py /var/task

CMD ["lambda_function.lambda_handler"]
