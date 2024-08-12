resource "aws_iam_role" "ecs_instance" {
  name = "ecs-instance${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs_instance"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "ec2:DescribeTags",
            "ecs:CreateCluster",
            "ecs:DeregisterContainerInstance",
            "ecs:DiscoverPollEndpoint",
            "ecs:Poll",
            "ecs:RegisterContainerInstance",
            "ecs:StartTelemetrySession",
            "ecs:UpdateContainerInstancesState",
            "ecs:Submit*",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecs:TagResource",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "*"
          ],
          Resource : "*",
          Effect : "Allow"
        },
      ]
    })
  }
  tags = {
    Name     = "ecs-instance${var.project}-${var.environment}"
    Category = "security"
  }
}

resource "aws_iam_role_policy_attachment" "ecsinstance_ssm_policy" {
  role       = aws_iam_role.ecs_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ecs_task" {
  name = "ecs-task${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ecs-tasks.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs_task"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "cloudwatch:GetMetricData",
            "ssm:DescribeParameters",
            "ssm:GetParametersByPath",
            "sqs:*",
            "ecs:UpdateService",
            "ses:SendEmail",
            "ses:SendRawEmail",
            "s3:*",
            "*"
          ],
          Resource : "*",
          Effect : "Allow"
        },
      ]
    })
  }
  tags = {
    Name     = "ecs-task${var.project}-${var.environment}"
    Category = "security"
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-execution${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ecs-tasks.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs_task_execution"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "cloudwatch:GetMetricData",
            "ssm:DescribeParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "secretsmanager:GetSecretValue",
            "kms:Decrypt",
            "sqs:*",
            "s3:*",
            "*"
          ],
          Resource : "*",
          Effect : "Allow"
        },
      ]
    })
  }
  tags = {
    Name     = "ecs-task-execution${var.project}-${var.environment}"
    Category = "security"
  }
}

resource "aws_iam_role" "ecs_service" {
  name = "ecs-service${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ecs.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs_service"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "ec2:AttachNetworkInterface",
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:DeleteNetworkInterface",
            "ec2:DeleteNetworkInterfacePermission",
            "ec2:Describe*",
            "ec2:DetachNetworkInterface",
            "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
            "elasticloadbalancing:DeregisterTargets",
            "elasticloadbalancing:Describe*",
            "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
            "elasticloadbalancing:RegisterTargets",
            "route53:ChangeResourceRecordSets",
            "route53:CreateHealthCheck",
            "route53:DeleteHealthCheck",
            "route53:Get*",
            "route53:List*",
            "route53:UpdateHealthCheck",
            "servicediscovery:DeregisterInstance",
            "servicediscovery:Get*",
            "servicediscovery:List*",
            "servicediscovery:RegisterInstance",
            "servicediscovery:UpdateInstanceCustomHealthStatus",
            "autoscaling:Describe*",
            "autoscaling:DeletePolicy",
            "autoscaling:PutScalingPolicy",
            "autoscaling:SetInstanceProtection",
            "autoscaling:UpdateAutoScalingGroup",
            "autoscaling-plans:CreateScalingPlan",
            "autoscaling-plans:DeleteScalingPlan",
            "autoscaling-plans:DescribeScalingPlans",
            "cloudwatch:DeleteAlarms",
            "cloudwatch:DescribeAlarms",
            "cloudwatch:PutMetricAlarm",
            "ec2:CreateTags",
            "ssm:DescribeSessions",
            "ssm:StartSession",
            "servicediscovery:CreateHttpNamespace",
            "servicediscovery:CreateService",
            "servicediscovery:TagResource",
            "servicediscovery:DeleteService",
            "servicediscovery:DiscoverInstances",
            "logs:CreateLogGroup",
            "logs:DescribeLogGroups",
            "logs:PutRetentionPolicy",
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents",
            "s3:*",
            "*"
          ],
          Resource : "*",
          Effect : "Allow"
        },
      ]
    })
  }
  tags = {
    Name     = "ecs-service${var.project}-${var.environment}"
    Category = "security"
  }
}

resource "aws_iam_role" "ecs_service_autoscaling" {
  name = "ecs-service-autoscaling${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "application-autoscaling.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "ecs_service_autoscaling"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "application-autoscaling:*",
            "ecs:DescribeServices",
            "ecs:UpdateService",
            "cloudwatch:DescribeAlarms",
            "cloudwatch:PutMetricAlarm",
            "cloudwatch:DeleteAlarms",
            "cloudwatch:DescribeAlarmHistory",
            "cloudwatch:DescribeAlarmsForMetric",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics",
            "cloudwatch:DisableAlarmActions",
            "cloudwatch:EnableAlarmActions",
            "iam:CreateServiceLinkedRole",
            "sns:CreateTopic",
            "sns:Subscribe",
            "sns:Get*",
            "sns:List*",
            "*"
          ],
          Resource : "*",
          Effect : "Allow"
        },
      ]
    })
  }
  tags = {
    Name     = "ecs-service-autoscaling${var.project}-${var.environment}"
    Category = "security"
  }
}

resource "aws_iam_role" "autoscaling_lifecycle_hook_notification_role" {
  name = "drain-lambda-event-target${var.project}-${var.environment}"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "autoscaling.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  })

  inline_policy {
    name = "autoscaling_lifecycle_hook_notification"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action : [
            "sns:Publish"
          ],
          Resource : "*",
          Effect : "Allow"
        }
      ]
    })
  }
  tags = {
    Name     = "drain-lambda-event-target${var.project}-${var.environment}"
    Category = "security"
  }
}
