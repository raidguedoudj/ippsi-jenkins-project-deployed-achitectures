resource "aws_security_group" "LOS-LYONS-DE-IPSSI-1-SG-ADMIN" {
        name = "LOS-LYONS-DE-IPSSI-1-SG-ADMIN"
        description = "LOS-LYONS-DE-IPSSI-1-SG-ADMIN"
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"

        
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

resource "aws_security_group" "LOS-LYONS-DE-IPSSI-1-SG-RPROXY" {
        name = "LOS-LYONS-DE-IPSSI-1-SG-RPROXY"
        description = "LOS-LYONS-DE-IPSSI-1-SG-RPROXY"
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"

        
        ingress {
                description = "Auto generated rule"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-ADMIN.id}"]
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

resource "aws_security_group" "LOS-LYONS-DE-IPSSI-1-SG-WEB" {
        name = "LOS-LYONS-DE-IPSSI-1-SG-WEB"
        description = "LOS-LYONS-DE-IPSSI-1-SG-WEB"
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"

        
        ingress {
                description = "Auto generated rule"
                from_port = 80
                to_port = 80
                protocol = "tcp"
                security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-RPROXY.id}"]
        }


        ingress {
                description = "Auto generated rule"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                security_groups = ["${aws_security_group.LOS-LYONS-DE-IPSSI-1-SG-ADMIN.id}"]
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

