#### Objective : VCC Project Project

Jojo Joseph (G23AI2100) Batch: 2024
Anirban Sinha (G23AI2084) Batch: 2024
Aparna Mundke (G23AI2003) Batch: 2024

PART 1 - Aparana
Frontend , Backend and Datebase.
( We are reusing the same Docker container)

PART 2 - Anirban
Docker Compose and VM and GCP Services
Locust API Load testing

PART 3 - Jojo
Terraform and GCP Services and testing on Cloud.



## Use the docker-compose

Run docker-compose up --build to build the images and bring up the services.

Make sure you have installed docker-compose and docker

docker-compose up --build

## Testing the application

Service-
Bankend - http://localhost:5001
Frontend - http://localhost:8000

## API Stress/Load Testing using Locust Python

## Step API LOAD test

cd api-load-testing/
pip install virtualenv
virtualenv -p python3 venv
cd venv/bin/  
source activate
cd ../..
pip install locust
locust -f api locustfile.py

Check the HTML output of locust.
http://0.0.0.0:8089

## Terraform

cd Terraform/

terraform init
terraform plan
terraform apply



## Create a docker network :

docker network create student_registery_network

## Database

cd DATABASE

docker build -t postgres:1.0.0 .

docker run -d --name postgres_db --network student_registery_network postgres:1.0.0

## Backend

cd BACKEND

docker build -t student_register_backend:1.0.0 .

docker run -d --name student_registery_backend -p 5000:5000 -e PG_HOST='postgres_db' --network student_registery_network student_register_backend:1.0.0

## Frontend

cd FRONTEND

docker build -t student_register_frontend:1.0.0 .

docker run -d --name student_registery_frontend -p 8000:8000 student_register_frontend:1.0.0

## Done

Go to browser localhost:8000

Add a record to the database using frontend.
