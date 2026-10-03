resource "docker_image" "api" {
  name = "iac-api:${terraform.workspace}"

  build {
    context    = "${path.module}/api"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "api" {
  image = docker_image.api.image_id
  name  = "api-${terraform.workspace}"

  ports {
    internal = 3000
    external = var.api_server_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.environment.name
  }

  env = [
    "ENTORNO=${terraform.workspace}",
    "DB_HOST=bd-${terraform.workspace}",
    "DB_PORT=5432",
    "DB_NAME=iac_${terraform.workspace}",
    "DB_USER=admin",
    "DB_PASSWORD=${var.postgres_password}"
  ]
}

output "api_server_port" {
  value = docker_container.api.ports[0].external
}