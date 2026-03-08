# Todo App Kubernetes Deployment (KIND + Ingress)

## Requirements

Before starting, ensure the following tools are installed:

* Docker Desktop
* kubectl
* kind
* git

Check installation:

```
docker --version
kubectl version --client
kind --version
```

---

# 1. Start Docker

KIND requires Docker to run.

Start **Docker Desktop** and verify:

```
docker info
```

---

# 2. Create Kubernetes Cluster

Create a local Kubernetes cluster using KIND:

```
kind create cluster --config cluster.yml
```

Verify cluster:

```
kubectl cluster-info
```

Check nodes:

```
kubectl get nodes
```

Expected output:

```
kind-control-plane
kind-worker
kind-worker2
```

---

# 3. Deploy Application Infrastructure

Make bootstrap script executable:

```
chmod +x bootstrap.sh
```

Run bootstrap script:

```
./bootstrap.sh
```

This script deploys:

* MySQL StatefulSet
* Todo application deployment
* Services
* Persistent volumes
* Nginx Ingress Controller

---

# 4. Verify Pods

Check all pods:

```
kubectl get pods -A
```

All pods should be in **Running** state.

Example:

```
mysql
todoapp
ingress-nginx
```

---

# 5. Create Ingress Resource

Apply ingress configuration:

```
kubectl apply -f .infrastructure/Ingress/ingress.yml
```

Verify ingress:

```
kubectl get ingress -n todoapp
```

---

# 6. Verify Service Endpoints

Ensure services are connected to pods:

```
kubectl get endpoints -n todoapp
```

Expected:

```
todoapp-service    10.x.x.x:8080
```

---

# 7. Access Application

Since KIND runs inside Docker, the easiest way to access the application is using port forwarding.

Run:

```
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80
```

Now open the application:

```
http://localhost:8080
```

Or test with curl:

```
curl localhost:8080
```

---

# Architecture

```
Browser
   ↓
localhost:8080
   ↓
Ingress Controller (NGINX)
   ↓
Ingress Rule
   ↓
todoapp-service
   ↓
todoapp pods
   ↓
MySQL StatefulSet
```

---

# Useful Commands

Check pods:

```
kubectl get pods -A
```

Check services:

```
kubectl get svc -A
```

Check ingress:

```
kubectl get ingress -A
```

View logs:

```
kubectl logs <pod-name> -n todoapp
```

---

# Delete Cluster

When finished testing:

```
kind delete cluster
```
