kind create cluster --config cluster.yml
./bootstrap.sh

kubectl apply -f .infrastructure/ingress/ingress-controller.yml 
kubectl get pods
kubectl get svc


#Check accessibility on http://localhost