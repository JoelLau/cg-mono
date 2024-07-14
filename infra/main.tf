terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.9.2"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key for authenticating terraform requests"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Access Key for authenticating terraform requests"
  sensitive   = true
}

variable "usdb_username" {
  type        = string
  description = "URL Shortener's DB Username"
  sensitive   = true
}

variable "usdb_password" {
  type        = string
  description = "URL Shortener's DB Password"
  sensitive   = true
}

variable "joels_tmp_ip" {
  type      = string
  sensitive = true
}

module "urlshortener" {
  source       = "./modules/url-shortener/"
  joels_tmp_ip = var.joels_tmp_ip
  db_username  = var.usdb_username
  db_password  = var.usdb_password
}
