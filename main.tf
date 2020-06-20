provider "digitalocean" {
  token = var.digitalocean_api_token
}

resource "digitalocean_tag" "lbaas_demo" {
  name = "lbaas-demo"
}

resource "digitalocean_droplet" "backend" {
  image    = var.droplet_image
  name     = "web${count.index + 1}.${var.domain_name}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = var.droplet_ssh_keys
  tags     = [digitalocean_tag.lbaas_demo.id]
  count    = var.droplet_count
}

resource "digitalocean_record" "backend" {
  domain = var.domain_name
  type   = "A"
  name   = "web${count.index + 1}"
  value  = digitalocean_droplet.backend[count.index].ipv4_address
  count  = var.droplet_count
}

resource "digitalocean_loadbalancer" "frontend" {
  name        = "lbaas-demo"
  region      = var.droplet_region
  droplet_tag = digitalocean_tag.lbaas_demo.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }
}

resource "digitalocean_record" "frontend" {
  domain = var.domain_name
  type   = "A"
  name   = "web"
  value  = digitalocean_loadbalancer.frontend.ip
}
