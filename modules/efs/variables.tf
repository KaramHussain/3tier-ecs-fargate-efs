variable "efs_name"{
    description = "The name of the EFS file system"
    type        = string
}

variable "security_groups" {
    description = "The security groups associated with the EFS mount targets"
    type        = list(string)
}

variable "subnet_id" {
    description = "The ID of the subnet in which the EFS mount target will be created"
    type        = list(string)
}