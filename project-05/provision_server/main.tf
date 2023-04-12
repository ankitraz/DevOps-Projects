terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "jenkins-server" {
    image = "ubuntu-22-04-x64"
    name = "ci-server"
    region = "blr1"
    size = "s-2vcpu-4gb"
    ssh_keys = [digitalocean_ssh_key.my-ssh-key.fingerprint]
    tags = [ "dev" ]
}
resource "digitalocean_droplet" "deployment-server" {
    image = "ubuntu-22-04-x64"
    name = "deployment-server"
    region = "nyc1"
    size = "s-2vcpu-4gb"
    ssh_keys = [digitalocean_ssh_key.my-ssh-key.fingerprint]
    tags = [ "dev" ]
}


resource "digitalocean_ssh_key" "my-ssh-key" {
    name = "server-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_firewall" "web" {
  name        = "only-22-80-firewall"
  droplet_ids = [digitalocean_droplet.jenkins-server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "droplet-id" {
    value = digitalocean_droplet.jenkins-server.ipv4_address
}

output "droplet-cost" {
    value = digitalocean_droplet.jenkins-server.price_monthly
}

resource "null_resource" "configure_server" {
    provisioner "local-exec" {
        command = "ansible-playbook -i ../configure_server/digitalocean.yaml --user root --private-key ~/.ssh/id_rsa /home/ankit/DevOps-Projects/project-05/configure_server/playbook.yaml"
    }
    triggers = {always_run = "${uuid()}"}
}


# ${digitalocean_droplet.jenkins-server.ipv4_address}