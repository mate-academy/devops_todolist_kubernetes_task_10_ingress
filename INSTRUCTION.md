### 1. Create cluster from file config:
```bash
kind create cluster --config cluster.yml
```

### 2. Run the bootstrap script:
```bash
./bootstrap.sh
```
This script will deploy the following resources: Cluster, PersistentVolume (pv.yml),  PersistentVolumeClaim (pvc.yml),  ConfigMap,  Secret, Deployment using the PVC, ConfigMap and Secret both for python Django app, MySQL db.

### 3. Create Ingress controller from file config:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl apply -f ./infrastructure/ingress/ingress.yml
```
### 4. Validate that the application is running
Check the status of the pods:
```bash
kubectl get pods
kubectl describe pod <pod-name>
```
### 5. Validate that ingress is running
Check the status of the pods:
```bash
kubectl get pods -o wide -n ingress-nginx 
kubectl describe pod <pod-name> -n ingress-nginx
```
### 6. Validate that ingress redirects path correctly
Go to http://localhost to see the Django app's title page and confirm no 404 status code.
