variable "web_server_port" {
  description = "The port on which the web server is exposed"
  type        = map(number)
}

variable "api_server_port" {
  description = "Puerto externo del servidor API"
  type        = map(number)
}