# Project - Deploy mongodb and mongoexpress in kubernetes cluster (minikube)

## Description
This project containes two  files: 
1. `mongo.yaml` - This file contains the deployment configuration for mongodb, mongoexpress and service configuration for both of them. It uses the configmap and secret to store the configuration for mongodb and mongoexpress.
   
2. `new.yaml` - This file contains the deployment for mongodb and mongoexpress but it does not use the configmap and secret to store the configuration for mongodb and mongoexpress.

## Run this project
1. `kubectl apply -f mongo.yaml` This will create the deployment and service and all other required resources for mongodb and mongoexpress.

2. After applying, you can check the status of the pods by running `kubectl get pods` command. You can also check the logs of the pods by running `kubectl logs <pod-name>` command.

3. Mongoexpress should be accessible at  `http://localhost:8081`