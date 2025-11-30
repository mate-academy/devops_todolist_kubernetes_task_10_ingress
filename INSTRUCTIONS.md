# How to deploy and validate Todo app Ingress

This document describes how to:

- create a kind cluster from `cluster.yml`;
- deploy MySQL and the Todo app;
- install the nginx Ingress controller;
- apply the Ingress resource;
- validate that the app is available on `http://localhost` without 404 errors.

---

## 1. Create kind cluster

From the repository root run:

```bash
kind create cluster --name todoapp --config cluster.yml


# Deploy all resources and Ingress controller
# Run the bootstrap script:
bash bootstrap.sh

# This script will:
# Create MySQL namespace, ConfigMap, Secret, Service and StatefulSet from .infrastructure/mysql/*.yml.
# Create the todoapp namespace and all app resources from .infrastructure/app/*.yml
# (PersistentVolume, PersistentVolumeClaim, Secret, ConfigMap, ClusterIP Service, NodePort Service, HPA, Deployment).
# Install the nginx Ingress controller from the official manifest.
# Apply the Ingress resource from .infrastructure/ingress/ingress.yml.


# Wait until all pods are running:
kubectl get pods -A


# Check created resources Namespaces
kubectl get ns


# Services and Deployment
kubectl get svc -n mysql
kubectl get svc -n todoapp
kubectl get deploy -n todoapp
kubectl get hpa -n todoapp


# Ingress
kubectl get ingress -n todoapp


# Validate HTTP access via Ingress
# Open the app in the browser
# Open http://localhost in your browser.
# Expected result:
# the Todo app main page is loaded;
# the app works as usual (you can open /api/ in the network tab if needed).


# Clean up
# When you finish testing, you can delete the cluster:
kind delete cluster --name todoapp