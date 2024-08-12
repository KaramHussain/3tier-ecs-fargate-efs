variable "vpc_id" {
  description = "The ID of the VPC in which to create the target group"
  type        = string 
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
}