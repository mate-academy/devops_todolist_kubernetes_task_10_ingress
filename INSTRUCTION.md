# Validation Instructions

## 1. Check the Kubernetes cluster

Verify that the kind cluster is running:
```bash
kind get clusters
kubectl get nodes
```

## 2. Check the ToDo application

Verify that the application pods are running:
```bash
kubectl get pods -n todoapp
```

## 3. Check the Service

Verify that the ToDo application Service exists:
```bash
kubectl get svc -n todoapp
```

## 4. Check the Ingress

Verify that the Ingress was created in the `todoapp` namespace:
```bash
kubectl get ingress -n todoapp
```

## 5. Check the Ingress Controller

Verify that the NGINX Ingress Controller is running:
```bash
kubectl get pods -n ingress-nginx
```

## 6. Test the application through Ingress

Open the following address in a browser:
```text
http://localhost
```
