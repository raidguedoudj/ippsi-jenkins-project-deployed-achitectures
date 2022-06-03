resource "aws_security_group" "TO-THE-SPACE-AND-BEYOND-SG-ADMIN" {
        name = "TO-THE-SPACE-AND-BEYOND-SG-ADMIN"
        description = "TO-THE-SPACE-AND-BEYOND-SG-ADMIN"
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"

        
        ingress {
                description = "Auto generated rule"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }


        egress {
               description = "Allow out traffic"
               from_port = 0
               to_port = 0
               protocol = "-1"
               cidr_blocks = ["0.0.0.0/0"]
               ipv6_cidr_blocks = []
        }


}

resource "aws_security_group" "TO-THE-SPACE-AND-BEYOND-SG-RPROXY" {
        name = "TO-THE-SPACE-AND-BEYOND-SG-RPROXY"
        description = "TO-THE-SPACE-AND-BEYOND-SG-RPROXY"
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"

        
        ingress {
                description = "Auto generated rule"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-ADMIN.id}"]
        }


        ingress {
                description = "Auto generated rule"
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }


        ingress {
                description = "Auto generated rule"
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }


        egress {
               description = "Allow out traffic"
               from_port = 0
               to_port = 0
               protocol = "-1"
               cidr_blocks = ["0.0.0.0/0"]
               ipv6_cidr_blocks = []
        }


}

resource "aws_security_group" "TO-THE-SPACE-AND-BEYOND-SG-WEB" {
        name = "TO-THE-SPACE-AND-BEYOND-SG-WEB"
        description = "TO-THE-SPACE-AND-BEYOND-SG-WEB"
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"

        
        ingress {
                description = "Auto generated rule"
                from_port = 80
                to_port = 80
                protocol = "tcp"
                security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-RPROXY.id}"]
        }


        ingress {
                description = "Auto generated rule"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                security_groups = ["${aws_security_group.TO-THE-SPACE-AND-BEYOND-SG-ADMIN.id}"]
        }


        egress {
               description = "Allow out traffic"
               from_port = 0
               to_port = 0
               protocol = "-1"
               cidr_blocks = ["0.0.0.0/0"]
               ipv6_cidr_blocks = []
        }


}

