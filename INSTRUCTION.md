### 1. Run the bootstrap script:
```bash
./bootstrap.sh
```
This script will deploy the following resources: Cluster, PersistentVolume (pv.yml),  PersistentVolumeClaim (pvc.yml),  ConfigMap,  Secret, Deployment using the PVC, ConfigMap and Secret both for python Django app, MySQL db and Ingress.
### 2. Validate that the application is running
Check the status of the pods:
```bash
kubectl get pods
kubectl describe pod <pod-name>
```
### 3. Validate that ingress is running
Check the status of the pods:
```bash
kubectl get pods -o wide -n ingress-nginx 
kubectl describe pod <pod-name> -n ingress-nginx
```
### 3. Validate that ingress redirects path correctly
Go to http://localhost to see the Django app's title page.
