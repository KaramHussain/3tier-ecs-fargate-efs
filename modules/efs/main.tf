resource "aws_efs_file_system" "efs" {
    creation_token = "efs"
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
    encrypted = "true"
    tags = {
        Name = var.efs_name
    }
}

locals {
  subnet_map = { for idx, subnet_id in var.subnet_id : idx => subnet_id }
}

resource "aws_efs_mount_target" "efs_mount_targets" {
  for_each       = local.subnet_map
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value
  security_groups = var.security_groups
}


resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy01",
    "Statement": [
        {
            "Sid": "Statement",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "*",
            "Action": [
                "*"
            ]
        }
    ]
}
POLICY
}
