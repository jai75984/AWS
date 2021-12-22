#Providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

#AWS Instance

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
  access_key = "AKIA2X36IX3CYPV4U27Y"
  secret_key = "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"
    
}

resource "aws_instance" "EC2_server" {
  ami           = "ami-07a4db51302058e77"
  instance_type = "t4g.micro"

  tags = {
    Name = "Demo EC2"
  }
}

#EBS Volume and Attachment

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size              = 40
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example.id
}

#Cloudwatch Metric

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2" 
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80" 
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
        InstanceId = aws_instance.example.id
      }
}