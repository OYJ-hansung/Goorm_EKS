############################
# Attaching a ebs to an ec2
############################
data "aws_ebs_volume" "buildsvr_ebs" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = [var.buildsvr_ebs_volume_type]
  }

  filter {
    name   = "tag:${var.buildsvr_ebs_volume_tag_key}"
    values = [var.buildsvr_ebs_volume_tag_val]
  }
}

resource "aws_volume_attachment" "buildsvr_ebs_att" {
  device_name = "/dev/xvdb"
  volume_id   = data.aws_ebs_volume.buildsvr_ebs.id
  instance_id = aws_instance.buildsvr.id
}
