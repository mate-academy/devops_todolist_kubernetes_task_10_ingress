Setup

Start Minikube:

minikube start
minikube addons enable ingress


Build and apply manifests:

kubectl apply -f infrastructure/

2. Check status
kubectl get pods
kubectl get svc
kubectl get ingress


All pods should be Running, and Ingress should have an external address.

3. Access the app

Get Minikube IP:

minikube ip


Then open in browser:

http://localhost


or

curl http://localhost


Ingress active

Service reachable on port 80

Application loads successfully at http://localhost