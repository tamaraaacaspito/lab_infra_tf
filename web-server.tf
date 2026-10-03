resource "docker_image" "nginx" {
    name  = "nginx:latest"
}

resource "docker_container" "webserver" {
    image = docker_image.nginx.image_id
    name = "web-${terraform.workspace}"
    ports {
        internal = 80
        external = var.web_server_port[terraform.workspace]
    }
}

output "web_server_port" {
    value = docker_container.webserver.ports[0].external
}