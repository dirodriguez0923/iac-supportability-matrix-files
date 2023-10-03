provider "aws" {
  region = "us-west-2"
}

# Amazon S3 (For CloudFront and storage)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Ensure this is globally unique
  acl    = "public-read"             # For CloudFront demonstration purposes
}

# Amazon CloudFront (Using the S3 bucket as origin)
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id   = "myS3Origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for S3 Bucket"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Amazon CloudWatch Alarm (Monitoring CPU Utilization for demonstration)
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric checks for high CPU"
  alarm_actions       = [] # Add ARNs (e.g., SNS topic) for actions
}

# Amazon EC2 Auto Scaling
resource "aws_launch_configuration" "example" {
  name          = "placeholder-launch-configuration"
  image_id      = "ami-0c55b159cbfafe1f0"  # Placeholder. Update with correct AMI ID.
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  min_size             = 1
  max_size             = 5
  availability_zones   = ["us-west-2a"]
}

# Amazon Elastic Block Store (EBS)
resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2a"
  size              = 40
}

# Amazon Elastic Container Registry (ECR)
resource "aws_ecr_repository" "example" {
  name = "my-ecr-repo"
}


