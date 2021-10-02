resource "aws_instance" "webserver" {

  count = length(var.subnet_ids)

  ami                    = "ami-00dfe2c7ce89a450b"
  subnet_id              = var.subnet_ids[count.index]
  key_name               = "Ansible"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0351e89750d76eee9"]

  tags          = {
    Name        = "SysProv-WebServer"
    Environment = "Production"
  }

   provisioner "file" {
    source      = "/home/ec2-user/.ssh/id_rsa.pub"
    destination = "/home/ec2-user/id_rsa.pub"
  }
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("~/sysprov.pem")
    host     = "${self.public_dns}"
  }
  root_block_device {
        volume_type     = "gp2"
        volume_size     = 8
        delete_on_termination   = true
  }

  user_data = file("config_ssh.sh")
}

resource "aws_lb_target_group_attachment" "sysprov" {

  count = length(var.subnet_ids)

  target_group_arn = aws_lb_target_group.sysprovtg.arn
  target_id        = "${aws_instance.webserver[count.index].id}"
  port             = 80
}
