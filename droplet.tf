resource "digitalocean_ssh_key" "dokku-ssh-key" {
    name = "dokku ssh key"
    public_key = "${file("${var.PUBLIC_SSH_KEY}")}"
}
resource "digitalocean_droplet" "dokku-demo" {
    image = "ubuntu-14-04-x64"
    name = "dokku-demo"
    region = "nyc3"
    size = "1gb"
    ssh_keys = ["${digitalocean_ssh_key.dokku-ssh-key.id}"]
    provisioner "file" {
        source = "scripts/install_dokku.sh"
        destination = "/tmp/install_dokku.sh"
        connection {
            user = "root"
            private_key = "${file("${var.PRIVATE_SSH_KEY}")}"
            agent = false
        }
    }
    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/install_dokku.sh",
        "/tmp/install_dokku.sh"
      ]
      connection {
          user = "root"
          private_key = "${file("${var.PRIVATE_SSH_KEY}")}"
          agent = false
      }
    }
}

output "output-dokku-demo-1" {
  value = "IP: ${digitalocean_droplet.dokku-demo.ipv4_address}"
}
