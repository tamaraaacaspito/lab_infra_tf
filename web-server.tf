resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "webserver" {
  image = docker_image.nginx.image_id
  name  = "web-${terraform.workspace}"

  ports {
    internal = 80
    external = var.web_server_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.environment.name
  }

  upload {
    content = templatefile("${path.module}/web/index.html.tftpl", {
      environment = terraform.workspace
    })
    file = "/usr/share/nginx/html/index.html"
  }

  upload {
    content = templatefile("${path.module}/web/nginx.conf.tftpl", {
      api_host = "api-${terraform.workspace}"
    })
    file = "/etc/nginx/conf.d/default.conf"
  }
}

output "web_server_port" {
  value = docker_container.webserver.ports[0].external
}