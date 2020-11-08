resource "aws_launch_configuration" "ecs_launch_configuration" {
    name = "ecs_launch_configuration"
    image_id = "ami-0669eafef622afea1"
    instance_type = "t2.micro"
    iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.id 

    root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups = [aws_security_group.ecs_sg.id]

    associate_public_ip_address = "true"

    key_name = var.ecs_key_pair_name

    user_data = <<EOF
                  #!/bin/bash
                  echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                  EOF

}

resource "aws_security_group" "ecs_sg" {
    vpc_id      = data.aws_vpc.default.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}