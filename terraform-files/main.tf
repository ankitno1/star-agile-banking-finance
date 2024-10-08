resource "aws_instance" "test_server" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "ankit"
  vpc_security_group_ids = ["sg-0bc97f8af1eaa9600"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./ankit.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test_server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test_server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Banking/terraform-files/ansibleplaybook.yml"
     }
  }
