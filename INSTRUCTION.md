# Instructions

## Deploy

```bash
bash bootstrap.sh
```

## Validate

### 1. Cluster is running

```bash
kubectl get nodes
```
Expected: all nodes status `Ready`

### 2. Ingress controller is running

```bash
kubectl get pods -n ingress-nginx
```
Expected: `STATUS Running`, `READY 1/1`

### 3. App is running

```bash
kubectl get pods -n todoapp
```
Expected: `STATUS Running`, `READY 1/1`

### 4. Ingress is created

```bash
kubectl get ingress -n todoapp
```
Expected: ingress `todoapp-ingress` with ADDRESS `localhost`

### 5. App is accessible

Open link: http://localhost
