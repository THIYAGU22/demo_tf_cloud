resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "ecs_autoscaling_group"
    max_size                    = var.max_instance_size
    min_size                    = var.min_instance_size
    desired_capacity            = var.desired_capacity
    launch_configuration        = aws_launch_configuration.ecs_launch_configuration.name
    vpc_zone_identifier         = [join(",", data.aws_subnet_ids.all.ids)]
    health_check_type           = "ELB"
}
  