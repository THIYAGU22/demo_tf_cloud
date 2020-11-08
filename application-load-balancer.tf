data "aws_vpc" "default" {
  default = true
} 

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

resource "aws_alb" "ecs_load_balancer" {
    name = "thiyagu-ecs-load-balancer"
    security_groups = [data.aws_security_group.default.id]
    subnets = data.aws_subnet_ids.all.ids
     tags={
        Name = "ecsTargetGroup"
    }
}

resource "aws_alb_target_group" "ecs_target_group" {
    name = "ThiyaguEcsTargetGroup"
    port = "80"
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id

    tags={
        Name = "ecsTargetGroup"
    }

    depends_on = [
                aws_alb.ecs_load_balancer,
    ]
}

resource "aws_alb_listener" "alb_listener" { 
    load_balancer_arn = aws_alb.ecs_load_balancer.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.ecs_target_group.arn
        type = "forward"
    }
}
