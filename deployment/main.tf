//definimos nuestro proveedor y su region
provider "aws"{
    region="eu-west-1"
} 

//Definimos nuestro firewall donde definiremos que trafico entra y sale de la EC2
resource "aws_security_group" "sever_sg"{
    name = "server-security-group" //le damos un nombre

//Definimos el trafico entrante

    ingress{ //habilitamos el uso de ssh
        from_port = 22
        to_port= 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{ //habilitamos el uso de http
        from_port = 80
        to_port= 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

//Definimos el trafico saliente, habilitando cualquier tipo de conexion desde nuestro servidor

    egress{ 
        from_port = 0
        to_port= 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

 //Definimos su ciclo de vida 

    lifecycle{
        create_before_destroy = true
    }
}

//Definimos la instancia en si

resource " aws_instance" "server" {
  ami = "ami-08935252a36e25f85" //identificador de la imagen de nuestra maquina virtual
  instance_type="t2.micro"
  vpc_security_group_ids=["${aws_security_group.sever_sg.id}"] //Asociamos el segurity_group a esta instancia
  key_name="deployment" //asociamos el nombre de la key creada anteriormente
}

output "serverIp" {
  value = "${aws_instance.server.public_ip}" //nos muestra la ip del server
}



