resource "docker_image" "postgres" {
  name = "postgres:16-alpine"
}

resource "docker_container" "database" {
  image = docker_image.postgres.image_id
  name  = "bd-${terraform.workspace}"

  ports {
    internal = 5432
    external = var.db_server_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.environment.name
  }

  env = [
    "POSTGRES_DB=iac_${terraform.workspace}",
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]
}

output "db_server_port" {
  value = docker_container.database.ports[0].external
}