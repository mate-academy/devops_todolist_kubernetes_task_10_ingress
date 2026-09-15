# Configure Basic Ingress Rules

## Prerequisites
* `kind` cluster running
* Namespace `todoapp` and `mysql`

### Step 1: Apply all manifests:

```bash
# Create Cluster
kind create cluster --config cluster.yml

# Install Ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Deploy Secrets
kubectl apply -f .infrastructure/app/secret.yml
kubectl apply -f .infrastructure/mysql/secret.yml

# Deploy ConfigMap
kubectl apply -f .infrastructure/app/configMap.yml
kubectl apply -f .infrastructure/mysql/configMap.yml

# Deploy Persistent Volume
kubectl apply -f .infrastructure/app/pv.yml

# Deploy Persistent Volume Claim
kubectl apply -f .infrastructure/app/pvc.yml

# Create ClusterIp service for `todoapp` application and `mysql` server
kubectl apply -f .infrastructure/app/clusterIp.yml
kubectl apply -f .infrastructure/mysql/service.yml

# Create deployment for `todoapp` application and `mysql` server
kubectl apply -f .infrastructure/app/deployment.yml
kubectl apply -f .infrastructure/mysql/statefulSet.yml

# Create Ingress Controller
kubectl apply -f .infrastructure/ingress/ingress.yml
```

### Step 2: Confirm all resources are running:

```bash
# Check ConfigMaps
kubectl get configmap -n todo
kubectl get configmap -n mysql

# Check Secrets
kubectl get secrets -n mysql
kubectl get secrets -n todoapp

# Check Deployment
kubectl get deployment -n todoapp

# Check Services
kubectl get svc -n todoapp

# Check Ingress
kubectl get ingress -n todoapp
```

### Step 3: Verify and validate the deployment works:

```bash
# Get pods for todoapp application
kubectl get pods -n todoapp

# Get pods for Ingress nginx controller
kubectl get pods -n ingress-nginx
```

To make sure todoapp is working use this link: http://localhost.