#!/bin/bash

echo "Starting deployment..."

# 1. Install NGINX Ingress Controller (Specific for Kind)
echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# 2. Namespaces
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/mysql-namespace.yml

# 3. Database Infrastructure (MySQL)
kubectl apply -f .infrastructure/mysql-secret.yml
kubectl apply -f .infrastructure/mysql-configmap.yml
kubectl apply -f .infrastructure/mysql-service.yml
kubectl apply -f .infrastructure/statefulSet.yml

kubectl create secret generic mysql-app-credentials \
  --from-literal=NAME=tododb \
  --from-literal=USER=mate_user \
  --from-literal=PASSWORD=mate_password_secret \
  --from-literal=HOST=mysql-0.mysql-service.mysql.svc.cluster.local \
  -n mateapp --dry-run=client -o yaml | kubectl apply -f -

# 4. App Resources
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/service.yml

# 5. --- INGRESS DEPLOYMENT ---
echo "Deploying Ingress..."
kubectl apply -f .infrastructure/ingress/ingress.yml

# 6. Background tasks
kubectl apply -f .infrastructure/hpa.yml
kubectl apply -f .infrastructure/daemonset.yml
kubectl apply -f .infrastructure/cronjob.yml

echo "Deployment finished! Open http://localhost to see your app."