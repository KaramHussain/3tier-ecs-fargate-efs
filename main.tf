provider "aws" {
  region = "us-east-1"
}


######################### CREATING vpc ########################################
module "VPC" {
  source                     = "./modules/vpc"
  vpc_cidr_block             = var.vpc_cidr_block
  vpc_name                   = var.vpc_name
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}


######################### CREATING BACKEND SECURITY GROUP#######################

module "backend_security_group" {
  source        = "./modules/security_group"
  name          = var.backend_security_group
  description   = var.backend_security_group_description
  vpc_id        = module.VPC.vpc_id
  ingress_rules = var.backend_ingress_rules
}


######################### CREATING EFS SECURITY GROUP############################

module "efs_security_group" {
  source        = "./modules/security_group"
  name          = var.efs_security_group
  description   = var.efs_security_group_description
  vpc_id        = module.VPC.vpc_id
  ingress_rules = var.efs_ingress_rules
}


######################### CREATING EFS ###########################################

module "efs" {
  source          = "./modules/efs"
  efs_name        = var.efs_name
  security_groups = [module.efs_security_group.security_group_id]
  subnet_id       = module.VPC.private_subnet_ids[*]
}


######################### CREATING ECS CLUSTER #################################

module "karam_ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = var.cluster_name
}


################################# ROLES ########################################

module "ecs_task_execution_role" {
  source = "./modules/roles"
}


######################### CREATING ECS TASK DEFINATION #########################

module "backend_task_defination" {
  source             = "./modules/task_defination"
  ecs_task_role_arn  = module.ecs_task_execution_role.ecs_task_arn
  ecs_task_execution_role_arn = module.ecs_task_execution_role.ecs_task_execution_arn
  family             = var.family
  efs_file_system_id = module.efs.file_system_id
}


########################### CREATING ELB SECURITY GROUP##########################

module "ELB_security_group" {
  source        = "./modules/security_group"
  name          = var.elb_security_group_name
  description   = var.elb_security_group_description
  vpc_id        = module.VPC.vpc_id
  ingress_rules = var.elb_taskapp_ingress_rules
}

########################### CREATING TARGET GROUP#### ###########################


module "task_backend_target_group" {
  source = "./modules/target_groups"
  target_group_name = var.TG_task_backend_name
  target_group_port = var.TG_task_backend_port
  vpc_id = module.VPC.vpc_id
}

############################# CREATING lOADBALANCER #############################

module "elb" {
  source = "./modules/elb"
  aws_lb_name = var.aws_lb_name
  aws_subnet_ids = module.VPC.public_subnet_ids
  aws_security_group_ids = [module.ELB_security_group.security_group_id]
  aws_lb_target_group_name = var.TG_task_backend_name
  aws_lb_target_group_port = var.TG_task_backend_port
  targetgroup_arn = module.task_backend_target_group.target_group_arn
}


############################### CREATING ECS SERVICE ###########################

module "ecs_service" {
  source = "./modules/ecs_service"
  task_definition_arn = module.backend_task_defination.ecs_task_defination_arn
  service_name        = var.service_name
  cluster_id          = module.karam_ecs_cluster.cluster_id
  security_groups     = [module.backend_security_group.security_group_id]
  subnets             = module.VPC.private_subnet_ids
  target_group_arn    = module.task_backend_target_group.target_group_arn
  container_name      = var.backend_taskapp_container_name
  container_port      = var.backend_taskapp_container_port
}


