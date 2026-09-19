#!/bin/bash

echo "Applying namespaces..."
kubectl apply -f .infrastructure/app/ns.yml
kubectl apply -f .infrastructure/mysql/ns.yml

echo "Deploying MySQL database..."
kubectl apply -f .infrastructure/mysql/secret.yml
kubectl apply -f init.sql
kubectl apply -f .infrastructure/mysql/service.yml
kubectl apply -f .infrastructure/mysql/statefulSet.yml

echo "Deploying Django ToDo App..."
kubectl apply -f .infrastructure/app/secret.yml
kubectl apply -f .infrastructure/app/configMap.yml
kubectl apply -f .infrastructure/app/clusterIp.yml
kubectl apply -f .infrastructure/app/nodeport.yml
kubectl apply -f .infrastructure/app/deployment.yml
kubectl apply -f .infrastructure/app/hpa.yml

echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

echo "Applying Ingress rules..."
kubectl apply -f .infrastructure/ingress/ingress.yml

echo "All resources deployed successfully!"