resource "yandex_vpc_network" "cloudvpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "publicnet" {
  name           = var.publicnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "privatenet" {
  name           = var.privatenet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = var.sg_name
  network_id = yandex_vpc_network.cloudvpc.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}
