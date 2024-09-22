# Configure the Google Cloud provider
provider "google" {
  credentials = file("service-account-key.json")
  project     = var.project_id  # Use the project ID from variables.tf
  region      = "us-central1"   # Specify your region
}

# Create a firewall rule to allow public access to ports 8000 and 5001
resource "google_compute_firewall" "allow_public_ports" {
  name    = "allow-public-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8000", "5001"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create an instance template
resource "google_compute_instance_template" "template" {
  name = "docker-training-template"

  machine_type = "f1-micro"  # 0.5 GB RAM
  region       = "us-central1"

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"  # Using Ubuntu 20.04 LTS
    auto_delete  = true
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    # Install required packages
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose git

    # Clone the GitHub repository
    git clone https://github.com/TheJojoJoseph/DockerTrainingIITJ.git /home/ubuntu/DockerTrainingIITJ

    # Navigate to the Docker Compose directory
    cd /home/ubuntu/DockerTrainingIITJ

    # Run Docker Compose
    sudo docker-compose up -d
  EOT
}

# Create a managed instance group
resource "google_compute_region_instance_group_manager" "ig_manager" {
  name               = "docker-training-ig"
  version            = {
    instance_template = google_compute_instance_template.template.self_link
  }
  base_instance_name = "docker-training-instance"
  target_size        = 1  # Initial instance count

  # Set auto-scaling
  autoscaling {
    min_replicas = 1
    max_replicas = 5
    target_cpu_utilization {
      target_utilization = 0.6
    }
  }

  region = "us-central1"
}

# Create a health check
resource "google_compute_health_check" "default" {
  name = "docker-training-health-check"
  http_health_check {
    port = 80
    request_path = "/"
  }
}

# Attach the health check to the instance group
resource "google_compute_region_autoscaler" "autoscaler" {
  name                = "docker-training-autoscaler"
  region              = "us-central1"
  target              = google_compute_region_instance_group_manager.ig_manager.self_link
  autoscaling_policy {
    min_replicas = 1
    max_replicas = 5
    cpu_utilization {
      target_utilization = 0.6
    }
  }
}

# Output the instance group URL
output "instance_group_url" {
  value = google_compute_region_instance_group_manager.ig_manager.self_link
}
