resource "docker_network" "environment" {
  name = "iac-${terraform.workspace}-network"
}