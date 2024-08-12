variable "service_name" {
    description = "The name of the ECS service"
    type        = string
}

variable "cluster_id" {
    description = "The ID of the ECS cluster"
    type        = string
}

variable "task_definition_arn" {
  type = string
}

variable "security_groups" {
    description = "The security groups associated with the ECS service"
    type        = list(string) 
}

variable "subnets" {
    description = "The subnets associated with the ECS service"
    type        = list(string)
}

variable "target_group_arn" {
    description = "The ARN of the target group"
    type        = string
}

variable "container_name" {
    description = "The name of the container"
    type        = string
}

variable "container_port" {
    description = "The port of the container"
    type        = number
}