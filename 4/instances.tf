resource "aws_instance" "TO-THE-SPACE-AND-BEYOND-MACHINE-ADMIN" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-ADMIN.id}"]
        subnet_id = "${aws_subnet.TO-THE-SPACE-AND-BEYOND-SUBNET-PUBLIC.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/NULL")}"
        associate_public_ip_address = true

        tags = {
                Name = "MACHINE-ADMIN"
        }
}

resource "aws_instance" "TO-THE-SPACE-AND-BEYOND-MACHINE-RPROXY" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-RPROXY.id}"]
        subnet_id = "${aws_subnet.TO-THE-SPACE-AND-BEYOND-SUBNET-PUBLIC.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/install_rproxy.sh")}"
        associate_public_ip_address = true

        tags = {
                Name = "MACHINE-RPROXY"
        }
}

resource "aws_instance" "TO-THE-SPACE-AND-BEYOND-MACHINE-WEB1" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-WEB.id}"]
        subnet_id = "${aws_subnet.TO-THE-SPACE-AND-BEYOND-SUBNET-PRIVATE.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/install_web.sh")}"
        associate_public_ip_address = false

        tags = {
                Name = "MACHINE-WEB1"
        }
}

