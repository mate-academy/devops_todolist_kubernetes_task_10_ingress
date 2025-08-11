#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="todo-kind"

echo "▶️  Creating kind cluster (if not exists)..."
if ! kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
  kind create cluster --name "${CLUSTER_NAME}" --config ./cluster.yml
else
  echo "ℹ️  Cluster ${CLUSTER_NAME} already exists, skipping create."
fi

echo "▶️  Installing ingress-nginx (kind provider)..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "⏳ Waiting for ingress controller to be Ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  -l app.kubernetes.io/component=controller \
  --timeout=180s

echo "▶️  Applying app manifests (Deployment/Service/Config)..."
# Якщо у тебе інші назви файлів — додай їх нижче або залиш як є, якщо вже існують:
for f in deployment.yml deploy.yml k8s/deployment.yml \
         service.yml svc.yml k8s/service.yml \
         configMap.yml confgiMap.yml configmap.yml k8s/configMap.yml \
         secret.yml mysql-secret.yml app-secret.yml
do
  if [ -f "$f" ]; then
    echo "  - kubectl apply -f $f"
    kubectl apply -f "$f"
  fi
done

echo "▶️  Applying Ingress..."
kubectl apply -f ./infrastructure/ingress/ingress.yml

echo "✅ Done. Check with: kubectl get pods,svc,ingress"
echo "Open http://localhost"
