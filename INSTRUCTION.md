# How to validate the changes:
# Deploy the resources:
./bootstrap.sh
# Apply the Ingress configuration:
kubectl apply -f .infrastructure/app/ingress.yml

# How to check if the Ingress resource has been created:
kubectl get ingress -n todoapp

# Check the Pods:
kubectl get pods -n ingress-nginx

# Open your browser and navigate to:
http://localhost

