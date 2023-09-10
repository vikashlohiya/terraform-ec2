# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
  access_key = ""   #Aws Access Key
  secret_key = ""  #Aws Secret key
}

output "myoutput"{
value="${var.instance-name}"
}

resource "aws_key_pair" "demo_key_pair" {
  key_name   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCOc8cBC0/B++y0pryMdfXGrn/Q7+eZ09iAOQI5g4c4vUOgH2FM/zTh6yGiNkscmFOGTEWKYPPaRef5YyO7huuJCX22fA95ybPxu1MPKTszy9vfNPPK3l6bHkxeX/RKF+akp4zsls4qZ+UDzcAdShbpNrPwXyzhTxeoIdE7/etHKDdAFMQQ1ldAurVaTKyhM8QFNr7ygH4FQYh42UrDEVkLF/uIVxs+IMh2CayZehpCFK6J/gT+MDE0qPNSAYJyDcBZeb1ogcrbWqWZZuINB2GkBLy5xyAvCnIZ85sD0gKuFm7KvoOgDtCPhx1m4hf4kaDVTUu4sthyZ2tjZmWBFrdZ2SkgiiwKTlwv7e7HDbiaQMeKzHdoJQG+F6SEcIRStyn/6cHPKNbtBNYQD6wx3tyM4gwiND3VrClA0x0uVgNdsFy1NG7cL6R8YS6hIA5DHCKWOLOr58j3fmmeJGYah/ThCepGZlmSQ1z581PiBaVeoSfnXxIGCbfDu9r+mULxDOk= ubuntu@ip-172-31-30-32"
}
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  key_name=aws_key_pair.demo_key_pair.key_name
  security_groups = [aws_security_group.terraformsg.name]
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update && sudo apt-get install nginx -y
    # Add more commands or scripts here
    EOF
  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "terraformsg" {
  name        = "terraformsg"
  description = "Example security group for EC2 instance using terraform"

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all incoming TCP traffic
  }

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all incoming UDP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # This means all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

# variables.tf

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "WebServer01"
}
