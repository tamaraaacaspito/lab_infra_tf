# Laboratorio IAC

Enfocar el laboratorio a utilizar terraform, haciendo uso de buenas practicas

Terraform esta vinculado a provisionamiento

Vamos a desplegar 1 imagen nginx utilizando terraform

Para QA 5000
Para DEV 4000

Cada entorno cuenta con tres servicios conectados
Frontend (NGINX) -> Backend (Node.js) -> Base de datos (PostgreSQL)

Se mantiene el workspace default en el puerto 3000 como entorno local

## Requisitos previos
- Docker Desktop
- Terraform
- Git

## Clonar el repositorio
git clone https://github.com/tamaraaacaspito/lab_infra_tf.git
cd lab_infra_tf

## Iniciar Terraform
Dentro de la carpeta del proyecto:
terraform init 

## Configurar variables
Se debe crear terraform.tfvars con la siguiente estructura:

´´´
web_server_port = {
  default = 3000
  dev     = 4001
  qa      = 5001
}

api_server_port = {
  default = 3001
  dev     = 4002
  qa      = 5002
}

db_server_port = {
  default = 3002
  dev     = 4003
  qa      = 5003
}

postgres_password = "contraseña"

´´´

## Workspaces
Se utiliza para separar los entornos:
- default
- dev
- qa

### DEV
```bash
terraform workspace select dev
terraform plan
terraform apply
docker ps
```

Frontend: http://localhost:4001
Backend: http://localhost:4002
PostgreSQL: localhost:4003

### QA

```bash
terraform workspace select qa
terraform plan
terraform apply
```

Frontend: http://localhost:5001
Backend: http://localhost:5002
PostgreSQL: localhost:5003

Desde la página se puede utilizar el botón **Probar conexión con Backend** para comprobar la comunicación