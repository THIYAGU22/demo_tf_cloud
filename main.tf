module "iam" {
    source = "./modules/IAM"
}

module "alb" {
    source = "./modules/ALB"
}

module "ec2" {
    source                    = "./modules/EC2"
    ecs-instance-profile-name = module.iam.ecs-instance-profile-name
}

module "ecs" {
    source = "./modules/ECS"
    ecs-target-group-arn = module.alb.ecs_target_group_arn
    ecs-service-role-arn = module.iam.ecs-service-role-arn
}