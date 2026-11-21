# How to validate the changes

# Create the kind cluster
# From the repository root, run:
kind create cluster --config cluster.yml
## Expected result:
# Set kubectl context to "kind-kind"
# You can now use your cluster with:
# kubectl cluster-info --context kind-kind

# Deploy the application
# Run:
./bootstrap.sh
# End of every line must be created of patched
# In case of error start ./bootstrap.sh again

# Check all pods:
kubectl get pods -A
## Expected result:
# MySQL pods have status 1/1 Running;
# the todoapp pods has status 1/1 Running;
# the ingress-nginx-controller pod has status 1/1 Running;
# there are no pods in CrashLoopBackOff or Error.

# Check the Ingress resource
# Run:
kubectl get ingress -n todoapp
kubectl describe ingress -n todoapp
## Expected result:
# Ingress class is nginx;
# the rule uses path /;
# the backend is todoapp-service:80;
# the backend has application endpoints.

# Check access through Ingress
# Run:
curl -I http://localhost/
## Expected result:
# HTTP/1.1 200 OK
# The application should also be available in a browser at:
# http://localhost/