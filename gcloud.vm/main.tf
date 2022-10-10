provider "google" {
  project     = "ivory-amphora-363115"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = file("account.json")
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
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("startup.sh")
}