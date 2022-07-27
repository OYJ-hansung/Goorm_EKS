data "aws_key_pair" "buildsvr_key"{
  include_public_key = true

  filter {
      name   = "tag:${var.key_pair_tag_key}"
      values = [var.key_pair_tag_value]
  }
}

resource "aws_instance" "buildsvr" {
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = data.aws_key_pair.buildsvr_key.key_name
  availability_zone = aws_subnet.public_subnet[0].availability_zone # Worker Node와 동일한 VPC, AZ

  associate_public_ip_address = true # IP 자동 부여 활성화

  root_block_device {
    volume_size = var.instance_size
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo mkdir /var/lib/jenkins
                sudo mount /dev/vg0/lv0 /var/lib/jenkins
                sudo apt-get update -y && sudo apt-get install -y openjdk-11-jre
                curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
                echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update -y && sudo apt-get install jenkins -y
                EOF

  tags = {
    Name = "Build Server"
  }
}
