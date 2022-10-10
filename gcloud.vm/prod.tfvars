#### provider ####
project_name = "ivory-amphora-363115"
region       = "us-central1"


########
name         = "ctfd"
machine_type = "e2-medium"
zone         = "us-central1-a"

tags = ["ctfd"]

image      = "ubuntu-os-cloud/ubuntu-2204-lts"
image_size = 100


network_name           = "isitdtu-network"
firewall_rule_name     = "isitdtuctf-firewall-http-https"
firewall_protocol      = "tcp"
firewall_ports         = ["80", "443"]
firewall_source_ranges = ["0.0.0.0/0"]