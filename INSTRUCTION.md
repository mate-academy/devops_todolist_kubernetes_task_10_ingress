# Instructions for Validating Ingress Changes

Follow these steps to deploy the cluster, application, and Ingress controller, and to verify that the setup works as expected.

## Prerequisites
Make sure you have `kind` and `kubectl` installed on your machine.

---

## Deployment Steps

### 1. Recreate the Kind Cluster**
   Delete any existing cluster named `kind` and create a new one using the provided configuration:
   ```
   kind delete cluster
   kind create cluster --config cluster.yml
   ```
Run the Bootstrap Script
Execute the bootstrap script to deploy the ToDo application and install the NGINX Ingress Controller:

```
./bootstrap.sh
```
Apply the Ingress Manifest
Deploy the Ingress resource that manages routing and handles URL rewrites:

```
kubectl apply -f ./infrastructure/ingress/ingress.yml
```
Verify Components are Ready
Wait for the Ingress Controller pods to be fully up and running (this might take a minute):

```
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
```
## Validation
Open your browser and navigate to http://localhost.

Verify that the Django ToDo list web application loads successfully.

Open the Browser Developer Tools (press F12 or right-click -> Inspect), and go to the Console tab.

Refresh the page and ensure there are no 404 Not Found errors for static files (CSS, JS). All paths and static assets should resolve properly due to the regex rewrite configuration.