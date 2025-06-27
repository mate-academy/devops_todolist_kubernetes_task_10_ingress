#!/bin/bash

# Створення namespace, якщо не існує
kubectl create namespace todoapp 2>/dev/null || echo "Namespace 'todoapp' вже існує"

# Розгортання застосунку
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/service.yml

# Встановлення ingress-nginx контролера
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/kind/deploy.yaml

# Очікування готовності ingress controller
echo "Очікуємо ingress-контролер..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

# Розгортання Ingress
kubectl apply -f .infrastructure/ingress/ingress.yml

# Port forward до ingress-контролера
echo "Port-forward до ingress-nginx (localhost:80)..."
kubectl port-forward --namespace ingress-nginx svc/ingress-nginx-controller 80:80
