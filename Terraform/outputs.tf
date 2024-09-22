# Output the instance group URL
output "instance_group_url" {
  value = google_compute_region_instance_group_manager.ig_manager.self_link
}