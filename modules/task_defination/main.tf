  resource "aws_ecs_task_definition" "efs_task" {
    family                   = var.family
    requires_compatibilities = ["FARGATE"]
    cpu                      = "256"
    memory                   = "512"
    network_mode             = "awsvpc"
    task_role_arn            = var.ecs_task_role_arn
    execution_role_arn       = var.ecs_task_execution_role_arn

    
    volume {
      name = "efs-html"
      efs_volume_configuration {
        file_system_id = var.efs_file_system_id
        transit_encryption = "ENABLED"
      }
    }

    container_definitions = <<DEFINITION
      [
          {
              "memory": 512,
              "cpu": 256,
              "portMappings": [
                  {
                      "hostPort": 80,
                      "containerPort": 80,
                      "protocol": "tcp"
                  }
              ],
              "essential": true,
              "mountPoints": [
                {
                    "containerPath": "/usr/share/nginx/html",
                    "sourceVolume": "efs-html",
                    "readOnly": false
                }
            ],
            "command": [
              "sh",
              "-c",
              "echo '<html><body><h1>Hello from Nginx</h1></body></html>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
            ],
            "name"  : "nginx",
            "image" : "nginx"
          }
      ]
      DEFINITION
  }

  output "ecs_task_defination_arn" {
    value = aws_ecs_task_definition.efs_task.arn
  }