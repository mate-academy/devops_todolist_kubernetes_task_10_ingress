#!/bin/bash

set -e

echo "Creating Kind cluster..."
kind create cluster --config=cluster.yml

echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

echo "Deploying application..."
kubectl apply -f infrastructure/

echo "Applying ingress configuration..."
kubectl apply -f infrastructure/ingress/

echo "Bootstrap completed successfully!"
echo "Access the application at: http://localhost"