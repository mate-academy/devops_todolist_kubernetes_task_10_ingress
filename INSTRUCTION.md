# Kubernetes Ingress Setup for Todo App

## Overview

This project configures an **NGINX Ingress** to expose the Todo application via HTTP.

All traffic from `http://localhost` is routed through the Ingress Controller to the application service inside the Kubernetes cluster.

---

## Prerequisites

* Docker installed
* `kind` installed
* `kubectl` installed

---

## Cluster Setup

Create the Kubernetes cluster:

```bash
kind create cluster --config cluster.yml
```

---

## Deploy Infrastructure

Run the bootstrap script to deploy all resources:

```bash
./bootstrap.sh
```

This script will:

* Deploy MySQL (StatefulSet + Service)
* Deploy Todo application (Deployment + Service)
* Install NGINX Ingress Controller
* Apply Ingress configuration

---

## Verify Resources

Check that all resources are running:

```bash
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```

Make sure:

* Pods are in `Running` state
* Ingress exists in `todoapp` namespace
* Backend service is `todoapp-service`

---

## Verify Ingress Configuration

```bash
kubectl describe ingress todoapp-ingress -n todoapp
```

Expected:

* Path: `/(/|$)(.*)`
* Backend: `todoapp-service:80`
* No errors like `service not found`

---

## Access the Application

After deploying all resources, the application is exposed via the Ingress Controller.

### Open in browser

By default, the application should be доступний at:

```text
http://localhost
``` 


### If the application is not accessible

Since `kind` does not expose ports by default, you may need to use port-forward:

```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
```

Then open:

```text
http://localhost:8080
```


---

## Validation

* Application UI loads successfully
* No 404 errors in browser console
* Ingress routes traffic correctly
* Pods and services are healthy

---

## Notes

* Ingress must be in the same namespace as the service (`todoapp`)
* Service name must match exactly (`todoapp-service`)
* Port forwarding is required when using `kind`
