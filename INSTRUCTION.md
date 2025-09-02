Create the kind cluster from the provided config:
kind create cluster --name todoapp --config cluster.yml
Bootstrap the cluster (installs NGINX ingress controller and deploys the app):
chmod +x bootstrap.sh && ./bootstrap.sh
Apply the Ingress manifest (if not already applied by bootstrap):
kubectl apply -f ./infrastructure/ingress/ingress.yml
Wait for resources to be ready:
kubectl get pods -n todoapp
Optionally: kubectl wait --for=condition=Ready pods --all -n todoapp --timeout=120s
Then proceed with your current validation steps:
Open http://localhost, check for 404s in the browser console, and optionally verify services with kubectl get svc -n todoapp.