#### Objective : DockerFile

Roll Number : g23ai2100
Batch: 2024
Name: Jojo Joseph

## Use the  docker-compose
Run docker-compose up --build to build the images and bring up the services.

docker-compose up --build

OR 

## Run the API LOAD test

virtualenv -p python3 venv
cd venv/bin/  
source activate
cd ../..
pip install locust
locust -f api-load-testing/locustfile.py

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
