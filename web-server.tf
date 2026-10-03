resource "docker_image" "nginx" {
    name  = "nginx:latest"
}

resource "docker_container" "webserver" {
    image = docker_image.nginx.image_id
    name = "web-server"
    ports {
        internal = 80
        external = var.web-server-port
    }
}

variable "web-server-port" {
    description = "The port on which the web server is exposed"
    type = number
    default = 3000
}

output "web-server-port" {
    value = docker_container.webserver.ports[0].external
}