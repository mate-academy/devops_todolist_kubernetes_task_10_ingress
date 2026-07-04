kind create cluster --config cluster.yml
run bootstrap.sh
kubectl apply -f .infrastructure/ingress/ingress.yml

kubectl get ns
kubectl get pods
kubectl get svc

http://localhost/
check nginx message: 404 not found