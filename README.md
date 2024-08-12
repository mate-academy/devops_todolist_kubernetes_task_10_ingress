# Deployment instructions

kind create cluster --config cluster.yml

# Apply all manifests at once

./bootstrap.sh

# Verify manifests

kubectl get pods -n todoapp

kubectl get pods -n mysql

kubectl get ingress -n todoapp

# Verify availabily of todoapp

http://localhost/
