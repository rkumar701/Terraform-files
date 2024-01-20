variable "ports" {
  type = list(number)
}

variable "instance_type" {
  type = string
}

variable "image_id" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "region" {
  type = string
}

variable "VPC-CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "VPC-subnet-pub-CIDR" {
  type    = string
  default = "10.0.0.0/24"
}

variable "VPC-subnet-pvt-CIDR" {
  type    = string
  default = "10.0.1.0/24"
}

variable "AZone-a" {
  type = string
}

variable "AZone-b" {
  type = string
}