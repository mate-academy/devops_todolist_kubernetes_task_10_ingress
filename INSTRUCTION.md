# TodoApp Infrastructure Validation Guide

This document provides instructions on how to deploy and validate the TodoApp infrastructure using Kind and Kubernetes.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running.
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) installed.
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed.

## Deployment Steps

1. **Create the Cluster**
   Spin up the Kubernetes cluster using the provided configuration:
   ```bash
   kind create cluster --config cluster.yml
   ```

2. **Bootstrap the Environment**
   Run the bootstrap script to deploy the database, the application, and the Ingress-Nginx controller:
   ```bash
   chmod +x bootstrap.sh
   ./bootstrap.sh
   ```

3. **Deploy Ingress**
   Apply the Ingress manifest located in the infrastructure directory:
   ```bash
   kubectl apply -f ./infrastructure/ingress/ingress.yml
   ```

## Validation

### 1. Verify Resource Status
Ensure all pods in the relevant namespaces are running. It may take a minute for the Ingress controller to become fully ready.
```bash
# Check application and database pods
kubectl get pods -A

# Specifically check Ingress-Nginx controller
kubectl get pods -n ingress-nginx
```

### 2. Access the Application
Open your web browser and navigate to:
[http://localhost](http://localhost)

The TodoApp interface should be visible and functional.

### 3. Check for Errors
To ensure the Ingress rules and regex path capturing are working correctly:
1. Right-click anywhere on the page and select **Inspect** (or press `F12`).
2. Go to the **Console** tab.
3. Refresh the page.
4. Verify that there are no requests failing with a **404 (Not Found)** status code. All static assets and API calls should return successful (2xx) status codes.

## Troubleshooting
If the application is not accessible, ensure that the Ingress controller pod is running on the `control-plane` node, as the port mappings (80/443) are bound to that specific node in the Kind configuration.
