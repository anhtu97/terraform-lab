provider "google" {
  project     = var.project_name
  region      = var.region
  zone        = var.zone
  credentials = file("account.json")
}

resource "google_compute_network" "isitdtu_network" {
  name = var.network_name
}

resource "google_compute_firewall" "web" {
  name    = var.firewall_rule_name
  network = google_compute_network.isitdtu_network.name

  allow {
    protocol = var.firewall_protocol
    ports    = var.firewall_ports
  }

  target_tags   = var.tags
  source_ranges = var.firewall_source_ranges
}

resource "google_compute_instance" "isitdtu" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.image_size
    }
  }

  network_interface {
    network = google_compute_network.isitdtu_network.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("startup.sh")
}