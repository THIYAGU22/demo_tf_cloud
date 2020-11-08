resource "aws_ecs_service" "thiyagu_ecs_service" {
    name = "thiyagu_ecs_service"
    iam_role = aws_iam_role.service_role_ecs.name 
    cluster = aws_ecs_cluster.thiyagu_ecs_cluster.id
    task_definition = aws_ecs_task_definition.php-container.arn
    desired_count = 1

    load_balancer {
        target_group_arn = aws_alb_target_group.ecs_target_group.arn
        container_port = 80
        container_name = "php-container"
    }
}