job "mysql-server" {
  datacenters = ["dc1"]
  type        = "service"

  group "mysql-server" {
    count = 1

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    ephemeral_disk {
      migrate = true
      size    = 300
      sticky  = true
    }

    task "mysql-server" {
      driver = "docker"

      config {
        image = "mysql/mysql-server:8.0"

        port_map {
          db = 3306
        }

        volumes = [
          "docker-entrypoint-initdb.d/:/docker-entrypoint-initdb.d/",
        ]
      }

      template {
        data = <<EOH
CREATE DATABASE dbwebappdb;
CREATE USER 'dbwebapp'@'%' IDENTIFIED BY 'dbwebapp';
GRANT ALL PRIVILEGES ON dbwebappdb.* TO 'dbwebapp'@'%';
EOH

        destination = "/docker-entrypoint-initdb.d/db.sql"
      }

      resources {
        cpu    = 500
        memory = 1024

        network {
          mbits = 10

          port "db" {}
        }
      }

      service {
        name = "mysql-server"
        port = "db"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
