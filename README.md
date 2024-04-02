# Todo App Kubernetes Deployment Guide
This guide provides instructions on deploying the Todo App within a Kubernetes cluster using the bootstrap.sh script, which automates the deployment process, including the setup of an Ingress controller to manage traffic.

## Prerequisites
- Kubernetes cluster (locally with kind or any cloud provider)
- kubectl configured to communicate with your cluster
- kind installed if you are using a local cluster

## Deployment Steps

1. Run the Bootstrap Script
Execute the bootstrap.sh script to deploy the MySQL database, Todo App, and Ingress controller:
```bash
./bootstrap.sh
```

2. Verify the Deployment
After running the script, ensure that all components are up and running:
```bash
kubectl get all -n todoapp
kubectl get all -n mysql
```

3. Check the Ingress resource to confirm it's set up correctly:
```bash
kubectl get ingress -n todoapp
```

## Accessing the Application
With the Ingress controller in place, you should be able to access the Todo App via http://localhost/ on your browser.

If you're using kind, ensure that the Ingress controller is set up to expose the application on localhost.

Troubleshooting
If you encounter any issues, you can check the logs of the specific component or describe the resource for more detailed information:

# Example: Checking logs of a pod
kubectl logs <pod-name> -n <namespace>

# Example: Describing an Ingress resource
kubectl describe ingress <ingress-name> -n <namespace>

Replace <pod-name>, <namespace>, and <ingress-name> with the relevant values for your setup. This README structure provides a comprehensive guide for users to deploy and access the Todo App using the provided bootstrap.sh script.
