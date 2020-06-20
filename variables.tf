variable "digitalocean_api_token" {
  type        = "string"
  description = "Token used to connect to the DigitalOcean API."
}

variable "domain_name" {
  type        = "string"
  description = "The domain name (zone) to use for DNS records."
}

variable "droplet_count" {
  type        = "string"
  description = "The number of backend Droplets to create."
  default     = "3"
}

variable "droplet_image" {
  type        = "string"
  description = "The distribution or snapshot to create a Droplet with."
  default     = "debian-9-x64"
}

variable "droplet_region" {
  type        = "string"
  description = "The region to create Droplets in."
  default     = "nyc3"
}

variable "droplet_size" {
  type        = "string"
  description = "The size of Droplet to create."
  default     = "s-1vcpu-1gb"
}

variable "droplet_ssh_keys" {
  type        = "list"
  description = "Numeric IDs of the SSH key(s) to insert from your account."
}
