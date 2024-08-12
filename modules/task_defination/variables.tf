variable ecs_task_role_arn {
    description = "The ARN of the ECS task role"
    type        = string
}

variable ecs_task_execution_role_arn {
    description = "The ARN of the ECS task execution role"
    type        = string
}


variable "family" {
    description = "The family of the ECS task definition"
    type        = string
}


variable "efs_file_system_id" {
    description = "The ID of the EFS file system"
    type        = string
}