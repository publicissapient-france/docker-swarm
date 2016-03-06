output "docker_infra_services_url" {
    value = "tcp://${aws_instance.docker_infra_services.public_ip}:2375"
}
output "docker_manager_url" {
    value = "tcp://${aws_instance.docker_manager_1.public_ip}:2375"
}
output "docker_slave_1_url" {
    value = "tcp://${aws_instance.docker_slave_1.public_ip}:2375"
}
output "docker_slave_2_url" {
    value = "tcp://${aws_instance.docker_slave_2.public_ip}:2375"
}
output "docker_slave_3_url" {
    value = "tcp://${aws_instance.docker_slave_3.public_ip}:2375"
}
