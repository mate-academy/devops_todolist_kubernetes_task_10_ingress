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



Now open the application:

```
http://localhost:80
```
curl localhost:80
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
