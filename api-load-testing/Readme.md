#### Objective : Run API loadtest 

pip install locust

locust -f locustfile.py

## Generate report
locust -f locustfile.py --headless -u 100 -r 10 --run-time 1m --html report.html


virtualenv -p python3 venv_name 
cd baseDirectory/bin/  
source activate  
deactivate 
