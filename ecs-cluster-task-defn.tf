resource "aws_ecs_cluster" "thiyagu_ecs_cluster" {
    name = var.ecs_cluster
}

data "aws_ecs_task_definition" "php-container" {
    task_definition = aws_ecs_task_definition.php-container.family
}

resource "aws_ecs_task_definition" "php-container" {
    family = "php-container"
    container_definitions = <<EOF
    [
        {
            "name" : "php-container",
            "image" : "358334558631.dkr.ecr.us-east-1.amazonaws.com/student-details:latest",
            "essential" : true,
            "portMappings" : [
               {
                  "containerPort" : 80,
                  "hostPort" : 80
               }
            ],
            "memory" : 500,
            "cpu"    : 10
        }
    ]
    EOF
}
