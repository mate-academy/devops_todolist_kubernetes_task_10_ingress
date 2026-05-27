# Instruction

## Deploy

```bash
kind create cluster --config cluster.yml
bash bootstrap.sh
```

## Validate

### 1. Check Ingress is created
```bash
kubectl get ingress -n todoapp
```
Expected: `todoapp-ingress` with ADDRESS `localhost`

### 2. Check Ingress controller is running
```bash
kubectl get pods -n ingress-nginx
```
Expected: pods in Running state

### 3. Check app pods are running
```bash
kubectl get pods -n todoapp
```
Expected: todoapp pods in Running state

### 4. Check app is accessible
Open `http://localhost` in browser and verify the app works.
Expected: no 404 errors in browser console
