resource "aws_iam_role" "service_role_ecs" {
    name = "service_role_ecs"
    path = "/"
    assume_role_policy = data.aws_iam_policy_document.ecs_service_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_service_role_attachment" {
    role = aws_iam_role.service_role_ecs.name
    policy_arn =  "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "ecs_service_policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ecs.amazonaws.com"]
        }
    }
}