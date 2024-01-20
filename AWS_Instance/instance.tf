
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = var.instance_name
  }

}
