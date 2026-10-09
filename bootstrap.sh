#!/bin/bash

echo "Spinning up Kind cluster from configuration..."
kind create cluster --config cluster.yml

echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml

echo "Waiting for Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx   --for=condition=ready pod   --selector=app.kubernetes.io/component=controller   --timeout=120s

echo "Applying Application Infrastructure..."
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f .infrastructure/app-db-secret.yml
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/todoapp-clusterip.yml

echo "Applying Ingress Routing Rules..."
kubectl apply -f infrastructure/ingress/ingress.yml

echo "All components deployed successfully!"
