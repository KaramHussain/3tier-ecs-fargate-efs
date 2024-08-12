######################### VPC #######################################

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "Karam"
}

# Declare variable for private subnet CIDR blocks
variable "private_subnet_cidr_blocks" {
  description = "value of the private subnet CIDR block"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Declare variable for public subnet CIDR blocks
variable "public_subnet_cidr_blocks" {
  description = "value of the public subnet CIDR block"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "availability_zones" {
  type        = list(string)
  description = "value of the availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

#######################################################################


variable "backend_security_group" {
  type        = string
  default     = "backend_security_group"
  description = "value of the security group name"
}

variable "backend_security_group_description" {
  type        = string
  default     = "Allow HTTP and HTTPS traffic"
  description = "value of the security group description"
}


variable "backend_ingress_rules" {
  description = "List of ingress rule objects"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "HTTPS ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

#########################################################

variable "efs_security_group" {
  type        = string
  default     = "efs_security_group"
  description = "value of the security group name"
}

variable "efs_security_group_description" {
  type        = string
  default     = "Allow NFS traffic"
  description = "value of the security group description"
}

variable "efs_ingress_rules" {
  description = "List of ingress rule objects"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "NFS ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

#########################################################

variable "efs_name" {
  type        = string
  description = "The name of the EFS file system"
  default     = "backend-efs"
}


#########################################################

variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster"
  default     = "karam-ecs-cluster"
}

############################################################

variable "family" {
  type        = string
  description = "The family of the ECS task definition"
  default     = "karam-ecs-task"
}


#############################################################

variable "service_name" {
  type        = string
  description = "The name of the ECS service"
  default     = "backend-service"
}


#############################################################

variable "elb_security_group_name" {
  type        = string
  default     = "elb_security_group"
  description = "value of the security group name"
  
}

#############################################################

variable "elb_security_group_description" {
  type        = string
  default     = "Allow HTTP and HTTPS traffic"
  description = "value of the security group name"
  
}


#############################################################

variable "elb_taskapp_ingress_rules" {
  description = "List of ingress rule objects"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "NFS ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}
#############################################################

variable "TG_task_backend_name" {
  description = "The name of the target group"
  type        = string
  default = "task-backend-tg"
}

#############################################################
variable "TG_task_backend_port" {
  description = "The port on which targets receive traffic"
  type        = number
  default = 80
}

#############################################################

variable "aws_lb_name" {
  description = "The name of the load balancer"
  type        = string
  default = "task-backend"
}

#############################################################

variable "target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
  default = 80
}

#############################################################

variable "backend_taskapp_container_name" {
  description = "The name of the container"
  type        = string
  default = "backend-taskapp"
}

#############################################################

variable "backend_taskapp_container_port" {
  description = "The port of the container"
  type        = number
  default = 80
}
