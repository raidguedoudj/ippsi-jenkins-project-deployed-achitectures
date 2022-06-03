resource "aws_vpc" "LOS-LYONS-DE-IPSSI-1-vpc" {
        cidr_block = "10.3.0.0/16"
        tags = {
                Name = "LOS-LYONS-DE-IPSSI-1-VPC"
        }
}

# A ajouter quand on génère le script : INFRA_NAME
resource "aws_subnet" "LOS-LYONS-DE-IPSSI-1-SUBNET-PUBLIC" {
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"
        cidr_block = "10.3.1.0/24"
        tags = {
                Name = "LOS-LYONS-DE-IPSSI-1-pub"
        }
}

resource "aws_subnet" "LOS-LYONS-DE-IPSSI-1-SUBNET-PRIVATE" {
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"
        cidr_block = "10.3.2.0/24"
        tags = {
                Name = "LOS-LYONS-DE-IPSSI-1-SUBNET-PRIVATE"
        }
}

resource "aws_internet_gateway" "LOS-LYONS-DE-IPSSI-1-igw" {
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"
        tags = {
                Name = "LOS-LYONS-DE-IPSSI-1-igw"
        }
}

resource "aws_eip" "LOS-LYONS-DE-IPSSI-1-nateip" {
}

resource "aws_nat_gateway" "LOS-LYONS-DE-IPSSI-1-natgw" {
        subnet_id = "${aws_subnet.LOS-LYONS-DE-IPSSI-1-SUBNET-PUBLIC.id}"
        allocation_id = "${aws_eip.LOS-LYONS-DE-IPSSI-1-nateip.id}"
        tags = {
                Name = "LOS-LYONS-DE-IPSSI-1-natgw"
        }
}

resource "aws_route" "LOS-LYONS-DE-IPSSI-1-defroute" {
        route_table_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.default_route_table_id}"
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.LOS-LYONS-DE-IPSSI-1-igw.id}"
}

resource "aws_route_table" "LOS-LYONS-DE-IPSSI-1-privrtb" {
        vpc_id = "${aws_vpc.LOS-LYONS-DE-IPSSI-1-vpc.id}"
        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = "${aws_nat_gateway.LOS-LYONS-DE-IPSSI-1-natgw.id}"
        }
}

resource "aws_route_table_association" "LOS-LYONS-DE-IPSSI-1-privrtb-assoc" {
        route_table_id = "${aws_route_table.LOS-LYONS-DE-IPSSI-1-privrtb.id}"
        subnet_id = "${aws_subnet.LOS-LYONS-DE-IPSSI-1-SUBNET-PRIVATE.id}"
}
