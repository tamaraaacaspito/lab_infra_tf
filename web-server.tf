resource "docker_image" "nginx" {
    name  = "nginx:latest"
}

resource "docker_container" "web-server" {
    image = docker_image.nginx.image_id
    name = "web-server"
    ports {
        internal = 80
        external = 3000
    }
}