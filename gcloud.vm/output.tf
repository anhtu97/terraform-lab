output "instance_private_ip" {
  description = "Private IP address of the instance"
  value       = google_compute_instance.isitdtu.network_interface.0.network_ip 
}

output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = google_compute_instance.isitdtu.network_interface.0.access_config.0.nat_ip  
}