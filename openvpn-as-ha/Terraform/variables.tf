variable "rds_instance_name" {
  default = "REMOVED FOR SECURITY"
}

variable "rds_db_name" {
  default = "REMOVED FOR SECURITY"
}

variable "allocated_storage" {
  default = REMOVED FOR SECURITY
}

variable "db_username" {
  default = "REMOVED FOR SECURITY" 
}

variable "db_password" {
  default = "REMOVED FOR SECURITY"
}

variable "ami_id" {
  default = "REMOVED FOR SECURITY"
}

variable "instance_type" {
  default = "t4g.medium"
}

variable "vpc_id" {
  default = "REMOVED FOR SECURITY" # vpc of choice
}

variable "subnet1_cidr" {
  default = "REMOVED FOR SECURITY"
}

variable "subnet2_cidr" {
  default = "REMOVED FOR SECURITY"
}

variable "az1" {
    default = "REMOVED FOR SECURITY"
}
variable "az2" {
    default = "REMOVED FOR SECURITY"
}

variable "default_region"{
    default = "REMOVED FOR SECURITY"
}

variable "openvpn_service_role"{
    default = ""
}

variable "deployment_role"{
    default = "arn:REMOVED FOR SECURITY"
}

variable "user_data" {
  type = string
  default = <<-EOF
    #!/bin/bash
    apt update
    apt install ansible awscli -y
  EOF
}

variable "service_descriptor" {
  default = "REMOVED FOR SECURITY"
}