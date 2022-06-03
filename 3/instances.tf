resource "aws_instance" "LOS-LYONS-DE-IPSSI-1-MACHINE-ADMIN" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-ADMIN.id}"]
        subnet_id = "${aws_subnet.LOS-LYONS-DE-IPSSI-1-SUBNET-PUBLIC.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/NULL")}"
        associate_public_ip_address = true

        tags = {
                Name = "MACHINE-ADMIN"
        }
}

resource "aws_instance" "LOS-LYONS-DE-IPSSI-1-MACHINE-RPROXY" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-RPROXY.id}"]
        subnet_id = "${aws_subnet.LOS-LYONS-DE-IPSSI-1-SUBNET-PUBLIC.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/install_rproxy.sh")}"
        associate_public_ip_address = true

        tags = {
                Name = "MACHINE-RPROXY"
        }
}

resource "aws_instance" "LOS-LYONS-DE-IPSSI-1-MACHINE-WEB1" {
        key_name = "vittorio_keypair"
        ami = "ami-021d41cbdefc0c994"
        security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-WEB.id}"]
        subnet_id = "${aws_subnet.LOS-LYONS-DE-IPSSI-1-SUBNET-PRIVATE.id}"
	instance_type = "t2.micro"
	user_data = "${file("SCRIPTS/install_web.sh")}"
        associate_public_ip_address = false

        tags = {
                Name = "MACHINE-WEB1"
        }
}

