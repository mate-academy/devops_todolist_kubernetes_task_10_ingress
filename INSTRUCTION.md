kind create cluster --config cluster.yml
kubectl apply -f ./infrastructure/ingress/ingress.yml
kubectl get ingress
kubectl describe deployment todoapp -n default
