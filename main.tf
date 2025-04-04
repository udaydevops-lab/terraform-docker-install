module "docker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "docker-instance"

  instance_type          = "t3.medium"
  vpc_security_group_ids = var.security_group_ids
  # convert StringList to list and get first element
  subnet_id = "subnet-0a6f1c9704ca109db"
  ami = data.aws_ami.ami_info.id
  user_data = file("install_docker.sh")
  iam_instance_profile   = "roboshop_ec2_route53"
  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 50
    }
  ]
  tags = merge(
    var.common_tags,
    {
        Name = "docker"
    }
  )
}



# resource "null_resource" "docker" {
#     triggers = {
#       instance_id = module.docker.id # this will be triggered everytime instance is created
#     }

#     connection {
#         type     = "ssh"
#         user     = "ec2-user"
#         password = "DevOps321"
#         host     = module.docker.public_ip
#     }

#     provisioner "file" {
#         source      = "./install_docker.sh"
#         destination = "/tmp/install_docker.sh"
#     }

#     provisioner "remote-exec" {
#         inline = [
#             "chmod +x /tmp/install_docker.sh",
#             "sudo sh /tmp/install_docker.sh"
#             # sudo sh backend.sh backend dev
#         ]
#     } 
# }