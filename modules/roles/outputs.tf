output "ecs_instance" {
  value = aws_iam_role.ecs_instance.id
}

output "ecs_instance_arn" {
  value = aws_iam_role.ecs_instance.arn
}

output "ecs_task" {
  value = aws_iam_role.ecs_task.id
}

output "ecs_task_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "ecs_task_execution" {
  value = aws_iam_role.ecs_task_execution.id
}

output "ecs_task_execution_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ecs_service" {
  value = aws_iam_role.ecs_service.id
}

output "ecs_service_arn" {
  value = aws_iam_role.ecs_service.arn
}

output "ecs_service_autoscaling" {
  value = aws_iam_role.ecs_service_autoscaling.id
}

output "ecs_service_autoscaling_arn" {
  value = aws_iam_role.ecs_service_autoscaling.arn
}

output "autoscaling_lifecycle_hook_notification_role" {
  value = aws_iam_role.autoscaling_lifecycle_hook_notification_role.id
}

output "autoscaling_lifecycle_hook_notification_role_arn" {
  value = aws_iam_role.autoscaling_lifecycle_hook_notification_role.arn
}