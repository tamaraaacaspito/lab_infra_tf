terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "4.6.0"
        }
    }
}

provider "docker" {

}

resource "docker_image" "ubuntu" {
    name  = "ubuntu:latest"
}

resource "docker_container" "foo" {
    image = docker_image.ubuntu.image_id
    name = "foo"
}