from locust import HttpUser, TaskSet, task, between

class APITasks(TaskSet):
    
    @task(1)
    def get_api(self):
        # Define the endpoint you want to hit
        response = self.client.get("/your/api/endpoint")
        if response.status_code == 200:
            print("Success")
        else:
            print(f"Failed with status code {response.status_code}")

    @task(1)
    def post_api(self):
        # Example of POST request
        payload = {"key": "value"}
        headers = {"Content-Type": "application/json"}
        response = self.client.post("/your/api/endpoint", json=payload, headers=headers)
        if response.status_code == 200:
            print("POST Success")
        else:
            print(f"POST Failed with status code {response.status_code}")

class APIUser(HttpUser):
    tasks = [APITasks]
    wait_time = between(1, 5)  # wait between 1 and 5 seconds between tasks
    host = "https://your.api.base.url"  # Base URL of your API