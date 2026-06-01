# Validation Instructions

## Prerequisites

* Docker
* kubectl
* kind

## Create Kubernetes Cluster

```bash
./bootstrap.sh
```

The script will:

* Create a Kind cluster
* Deploy MySQL
* Deploy ToDo application
* Install NGINX Ingress Controller
* Deploy Ingress resource

## Verify Deployment

Check application pods:

```bash
kubectl get pods -n todoapp
```

Check services:

```bash
kubectl get svc -n todoapp
```

Check ingress:

```bash
kubectl get ingress -n todoapp
```

Expected output:

```text
todoapp-ingress
```

## Validate Application

Open browser:

```text
http://localhost
```

Expected result:

* ToDo application is available
* Application UI is loaded correctly
* No requests fail with HTTP 404 status code in browser Developer Tools

## Additional Verification

Check ingress details:

```bash
kubectl describe ingress todoapp-ingress -n todoapp
```

Check ingress controller:

```bash
kubectl get pods -n ingress-nginx
```

All ingress controller pods should be in Running state.
