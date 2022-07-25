variable "cluster_name" {
  default = "GoormProjectEKS"
  type    = string
}

variable "instance_type" {
  default = "t3.medium"
  type    = string
}

# VPC
variable "public_subnet_cidr" {
  description = "VPC CIDR BLOCK LIST"
  default = ["172.20.0.0/20", "172.20.16.0/20"]
}

variable "private_subnet_cidr" {
  description = "VPC CIDR BLOCK LIST"
  default = ["172.20.32.0/20", "172.20.48.0/20"]
}
