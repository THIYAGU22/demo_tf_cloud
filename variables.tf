variable "region" {
    default = "us-east-1"
}
variable "ecs_cluster" {
    default = "thiyagu-student-details"
}
variable "ecs_key_pair_name" {
    default = "coda_global"
}

variable "max_instance_size" {
    default = 1
}

variable "min_instance_size" {
    default = 1
}

variable "desired_capacity" {
    default = 1
}