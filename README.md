QA Test Deployment and Automation


This repository provides the instructions and resources for deploying and verifying a frontend and backend service integration using Kubernetes and automated testing with Java and TestNG.



Project Overview


This project demonstrates how to deploy a frontend and backend service to a local Kubernetes cluster, verify their communication, and automate testing to ensure correct integration.


Prerequisites


Before you begin, ensure you have the following tools installed:
* Docker
* Minikube
* Java
* Test NG
* IDE (Eclipse, IntelliJ)
* Maven (for managing Java dependencies)


Instructions


Deployment


1. Clone the Repository


git clone https://github.com/Vengatesh-m/qa-test 

cd qa-test




2. Start Minikube


minikube start




3. Deploy Services to Kubernetes


Apply the Kubernetes YAML files to deploy the frontend and backend services:

        kubectl apply -f backend-deployment.yaml
        kubectl apply -f frontend-deployment.yaml
  

Verification


4.  Verify Frontend-Backend Communication


Get the service URL for the frontend:


          minikube service frontend-service --url




5. Access the frontend URL in your browser to check if the greeting message is displayed. Ex:

        http://127.0.0.1:55635/




Automation Testing


6. Set Up Java Project


7. Install Dependencies


Navigate to the test directory and add TestNG and other dependencies to your pom.xml:

<dependencies>

		<dependency>
			<groupId>org.seleniumhq.selenium</groupId>
			<artifactId>selenium-java</artifactId>
			<version>4.16.0</version> 
		</dependency>


		<dependency>
			<groupId>org.testng</groupId>
			<artifactId>testng</artifactId>
			<version>7.0.0</version>
		</dependency>


		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpclient</artifactId>
			<version>4.5.13</version> 
		</dependency>


		<dependency>
			<groupId>io.github.bonigarcia</groupId>
			<artifactId>webdrivermanager</artifactId>
			<version>5.5.3</version>
		</dependency>
	</dependencies>


8. Compile and Run Tests


The TestNG test script, located in src/test/java, performs the following checks:
* Sends an HTTP request to the frontend service.
* Verifies that the response contains the expected greeting message from the backend service.
  


Troubleshooting
* If you encounter issues, check the Kubernetes pod logs:
        kubectl logs <pod-name>
* Ensure all services are running and reachable within the cluster.
