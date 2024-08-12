output "file_system_id" {
    value = aws_efs_file_system.efs.id
  
}

output "file_system_arn" {
    value = aws_efs_file_system.efs.arn
}

# output "efs_access_point_id" {
#   value = aws_efs_access_point.test.id
# }