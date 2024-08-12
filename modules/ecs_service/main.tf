resource "aws_ecs_service" "ecs_service" {
  name             = var.service_name
  cluster          = var.cluster_id
  task_definition  = var.task_definition_arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  
  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = var.container_port
  }
}