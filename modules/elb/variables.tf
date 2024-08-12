variable "aws_lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "aws_subnet_ids" {
  description = "The IDs of the subnets in which to create the load balancer"
  type        = list(string)
}

variable "aws_security_group_ids" {
  description = "The IDs of the security groups to assign to the load balancer"
  type        = list(string)
}

variable "aws_lb_target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "aws_lb_target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
}


variable "targetgroup_arn" {
  description = "The ARN of the target group"
  type        = string
}
