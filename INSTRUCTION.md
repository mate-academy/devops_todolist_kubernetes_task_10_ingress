# Preconditions

```bash
kind create cluster --config cluster.yml
./bootstrap.sh
kubectl apply -f .infrastructure/ingress/ingress.yml
```

# Validation Instructions

Check resources
```bash
kubectl get pods -n todoapp
kubectl get ingress -n todoapp
```
Check there is no 404 error 
Open the app in a browser: http://localhost