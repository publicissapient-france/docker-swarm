output "docker_manager_url" {
    value = "${aws_instance.docker_manager_1.public_ip}"
}
output "docker_slave_1_url" {
    value = "${aws_instance.docker_slave_1.public_ip}"
}
output "docker_slave_2_url" {
    value = "${aws_instance.docker_slave_2.public_ip}"
}
output "docker_slave_3_url" {
    value = "${aws_instance.docker_slave_3.public_ip}"
}
