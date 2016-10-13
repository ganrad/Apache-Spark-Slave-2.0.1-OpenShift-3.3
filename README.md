# Apache Spark on OpenShift v3.3
### Run Apache Spark slave (2.0.1) within a Docker container on OpenShift Container Platform v3.3 (or above)

#### Instructions for deploying to OpenShift Container Platform 3.3 (or above)
1. Clone this git repository.  And copy the GIT URL to your GIT repo.  
2. Log into OpenShift via CLI  
3. Set your current project to Apache Spark project as below. This project should already exist and the Spark master container should have been already deployed and running.
  ```
  $ oc project apache-spark
  ```
4. Next, create a new application.  
  ```
  $ oc new-app [Path to GIT URL .git] --name=spark-slave  
  ```
5. Get a list of all services.  
  ```
  $ oc get svc
  ```
  The spark-slave service should be listed in the output.
6. Log into Apache Spark Web UI and you should be able to view the spark worker connected to the master and ready to accept jobs.

#### Optional Steps:
1. List all pods - oc get pods  
2. Tail/View the log for the build/deploy pods - oc logs -f [Name or ID of build or deploy pod]  

