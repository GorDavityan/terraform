provider "aws" {
    region = "us-east-1"
  }

#**********************************************************#

data "aws_ami" "amazon_linux"{
 most_recent      = true
 owners           = [137112412989]
filter {
    name          = "name"
    values        = ["amzn2-ami-kernel-5.10-hvm-2.0.20220316.0-x86_64-gp2"]
  }
}

#**********************************************************#

resource "aws_launch_configuration" "config_of_ASG" {
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  }

#**********************************************************#

  resource "aws_autoscaling_group" "myfirstASG" {
  name                 = "myfirstASG"
  launch_configuration = aws_launch_configuration.config_of_ASG.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  }
  ##