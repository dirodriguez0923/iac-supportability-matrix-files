provider "aws" {
  region = "us-west-2"  # adjust this to your preferred AWS region
}

resource "aws_instance" "basic_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update this to a valid AMI ID in your region
  instance_type = "t2.micro"

  tags = {
    Name = "BasicEC2Instance"
  }
}

resource "aws_s3_bucket" "basic_s3" {
  bucket = "my-unique-bucket-name"  # Make sure this is globally unique
  acl    = "private"
}

resource "aws_lambda_function" "basic_lambda" {
  filename      = "lambda_function_payload.zip"  # A zip file containing your Lambda function code
  function_name = "lambda_function_name"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"  # Your runtime's handler value

  # The below values depend on the runtime you are using, the example is for Node.js
  runtime = "nodejs14.x"
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

