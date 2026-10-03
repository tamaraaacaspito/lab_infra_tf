variable "web_server_port" {
  description = "The port on which the web server is exposed"
  type        = map(number)
}

variable "api_server_port" {
  description = "Puerto externo del servidor API"
  type        = map(number)
}

variable "db_server_port" {
  description = "Puerto externo del servidor PostgreSQL"
  type        = map(number)
}

variable "postgres_password" {
  description = "Contraseña de PostgreSQL"
  type        = string
  sensitive   = true
}