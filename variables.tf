######
# VPC
######
variable "vpc_name" {
  description = "VPC NAME"
  default     = "SWM-vpc"
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
variable "sg_allow_all" {
  description = "Name of security group"
  default     = "sg_allow_all"
}

variable "sg_allow_all_description" {
  description = "Description of security group"
  default     = "Security group"
}

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

#######
# EC2
######
variable "key_pair_tag_key" {
  description = "Key of key pair tag"
  type        = string
  default     = "key"
}

variable "key_pair_tag_value" {
  description = "Value of key pair tag"
  default     = "key"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default     = "ami-0ea5eb4b05645aa8a" # ap-northeast-2 Ubuntu Server 20.04 LTS x64(x86)
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.medium"
}

variable "instance_size" {
  description =  " Size of the volume in gibibytes (GiB)"
  default     =  10
}

######
# IAM
######
variable "eks_cluster_role_name" {
  description = "Name of IAM role"
  default     = "eks_cluster"
}

variable "eks_node_role_name" {
  description = "Name of IAM role"
  default     = "eks_nodes"
}

variable "eks_cluster_policy_arns" {
  description = "AWS of any policies to attach to the IAM role"
  type        = set(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
}

variable "eks_node_policy_arns" {
  description = "AWS of any policies to attach to the IAM role"
  type        = set(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

#####################
# Additional Volumes
#####################
variable "buildsvr_ebs_volume_type"{
  description = "Type of ebs"
  default     = "gp2"
}

variable "buildsvr_ebs_volume_tag_key" {
  description = "key of tag"
  default     = "owner"
}

variable "buildsvr_ebs_volume_tag_val" {
  description = "Value of tag"
  default     = "build"
}

######
# EKS
######
variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "terraform-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  default     = "1.22"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = true
}

###############
# Worker nodes
###############
variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  default     = "eks_nodes_t2"
}

variable "eks_nodes_instance_types" {
  description = "List of instance types associated with the EKS node group"
  default     = ["t2.medium"]
}

variable "eks_nodes_disk_size" {
  description = "Disk size in GiB for worker nodes"
  default     = 20
}

variable "eks_node_labels" {
  description = "Map of kubernetes labels"
  type        = map(string)
  default     = {
    role = "eks-t2-medium"
  }
}

variable "eks_node_sc_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "eks_node_sc_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "eks_node_sc_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "eks_node_key_name" {
  description = "EKS node Key Pair name"
  default     = "key0722"
}

######
# EIP
######
variable "buildsvr_eip_name" {
  description = "buildsvr_eip_name"
  default     = "buildsvr"
}

variable "worker_node_eip_name" {
  description = "worker_node_eip_name"
  default     = "worker-node"
}
