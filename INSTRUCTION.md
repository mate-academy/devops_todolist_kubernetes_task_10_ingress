
#  Validation

#### Create the cluster: 
```bash
kind create cluster --config cluster.yml
```

#### Deploy the app and ingress controller: 
```bash
bash bootstrap.sh
```

#### Check the controller runs on `kind-control-plane`:
```bash
kubectl get pods -n ingress-nginx -o wide
```

#### Apply the completed Ingress manifest:
```bash
kubectl apply -f .infrastructure/ingress/ingress.yml -n todoapp
```

####  Check the Ingress and app endpoints:
```bash
kubectl get ingress,pods,services,endpoints -n todoapp
```
Open `http://localhost` and confirm app is running correctly.