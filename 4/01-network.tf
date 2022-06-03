resource "aws_vpc" "TO-THE-SPACE-AND-BEYOND-vpc" {
        cidr_block = "10.4.0.0/16"
        tags = {
                Name = "TO-THE-SPACE-AND-BEYOND-VPC"
        }
}

# A ajouter quand on génère le script : INFRA_NAME
resource "aws_subnet" "TO-THE-SPACE-AND-BEYOND-SUBNET-PUBLIC" {
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"
        cidr_block = "10.4.1.0/24"
        tags = {
                Name = "TO-THE-SPACE-AND-BEYOND-pub"
        }
}

resource "aws_subnet" "TO-THE-SPACE-AND-BEYOND-SUBNET-PRIVATE" {
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"
        cidr_block = "10.4.2.0/24"
        tags = {
                Name = "TO-THE-SPACE-AND-BEYOND-SUBNET-PRIVATE"
        }
}

resource "aws_internet_gateway" "TO-THE-SPACE-AND-BEYOND-igw" {
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"
        tags = {
                Name = "TO-THE-SPACE-AND-BEYOND-igw"
        }
}

resource "aws_eip" "TO-THE-SPACE-AND-BEYOND-nateip" {
}

resource "aws_nat_gateway" "TO-THE-SPACE-AND-BEYOND-natgw" {
        subnet_id = "${aws_subnet.TO-THE-SPACE-AND-BEYOND-SUBNET-PUBLIC.id}"
        allocation_id = "${aws_eip.TO-THE-SPACE-AND-BEYOND-nateip.id}"
        tags = {
                Name = "TO-THE-SPACE-AND-BEYOND-natgw"
        }
}

resource "aws_route" "TO-THE-SPACE-AND-BEYOND-defroute" {
        route_table_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.default_route_table_id}"
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.TO-THE-SPACE-AND-BEYOND-igw.id}"
}

resource "aws_route_table" "TO-THE-SPACE-AND-BEYOND-privrtb" {
        vpc_id = "${aws_vpc.TO-THE-SPACE-AND-BEYOND-vpc.id}"
        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = "${aws_nat_gateway.TO-THE-SPACE-AND-BEYOND-natgw.id}"
        }
}

resource "aws_route_table_association" "TO-THE-SPACE-AND-BEYOND-privrtb-assoc" {
        route_table_id = "${aws_route_table.TO-THE-SPACE-AND-BEYOND-privrtb.id}"
        subnet_id = "${aws_subnet.TO-THE-SPACE-AND-BEYOND-SUBNET-PRIVATE.id}"
}
