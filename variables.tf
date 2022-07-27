variable "cluster_name" {
  default = "GoormProjectEKS"
  type    = string
}

variable "instance_type" {
  default = "t3.medium"
  type    = string
}

######
# VPC
######
variable "vpc_name" {
  description = "VPC NAME"
  default     = "terraform-vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR BLOCK"
  # default = "172.20.0.0/16"
  default     = "172.16.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "List of pulic subnet cidr block"
  # default    = ["172.20.0.0/20", "172.20.16.0/20"]
  default     = ["172.16.0.0/20", "172.16.16.0/20"]
}

variable "private_subnet_cidr_blocks" {
  description = "List of private subnet cidr block"
  # default     = ["172.20.32.0/20", "172.20.48.0/20"]
  default     = ["172.16.32.0/20", "172.16.48.0/20"]
}

variable "az" {
  description = "List of availability zone"
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

#################
# Security Group
#################
variable "sg_eks_cluster_name" {
  description = "Name of security group"
  default     = "sg_eks_cluster"
}

variable "sg_eks_cluster_description" {
  description = "Description of security group"
  default     = "Security group"
}

variable "sg_eks_cluster_ingress_port" {
  description = "List of ingress port on security group"
  default     = [443]
}
