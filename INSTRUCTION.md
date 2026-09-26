# Validation Instructions

## 1. Create the Kubernetes cluster

kind create cluster --config cluster.yml

## 2. Verify the cluster nodes

kubectl get nodes

## 3. Deploy the application and NGINX Ingress Controller

bash bootstrap.sh

Wait until the application and Ingress Controller pods are running.

## 4. Verify the application pods

kubectl get pods -n todoapp

## 5. Configure the Ingress Controller node

kubectl patch deployment ingress-nginx-controller -n ingress-nginx -p '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true"}}}}}'

Verify that the Ingress Controller is running on kind-control-plane:

kubectl get pods -n ingress-nginx -o wide

## 6. Verify the Ingress resource

kubectl get ingress -n todoapp

## 7. Validate the application

curl http://localhost

The command should return the application HTML.

Open http://localhost in the browser and verify that the application works correctly and required requests do not return 404 responses.