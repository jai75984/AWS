
provider "aws"{
    region = "us-east-1"
    access_key = "create IAM keys"
    secret_key = "create IAM keys"
}

resource "aws_instance" "Demo-EC2"{

    ami = "ami-047a51fa27710816e"
    instance_type = "t2.micro"
    count = "1"
    key_name = "ec2lab"

    tags={
        Name = "terraform-demo-server"
    }
}