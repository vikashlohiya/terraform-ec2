# Create Security Group , Key Pair and Ec2 with Nginx

# Create IAM user with adminstartive access

Create IAM user with adminstartive in aws account and get access_key and secret_key and paste into in aws provider

 # Install Terraform on local host 
  Use below url 
  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

 # Run Bellow Command
  teraform plan   
  teraform apply  
  teraform destroy  

 # Check in aws
  You will get one Security group with name "terraformsg"  
  You will get one key pair with name "terraform"  
   You will get one ec2 with name "WebServer01"  

# Connect EC2 
 if you need to connect ec2 through shh file , you can download it from "private pem file/terraform.pem"  
 Like
 ssh -i "terraform.pem" ubuntu@ec2-[your ip of created ec2].us-west-2.compute.amazonaws.com
 
    
 



  


  


