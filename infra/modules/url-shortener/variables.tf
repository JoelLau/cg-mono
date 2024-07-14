variable "aws_region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "joels_tmp_ip" {
  description = "Your IP address with CIDR notation"
  type        = string
}
