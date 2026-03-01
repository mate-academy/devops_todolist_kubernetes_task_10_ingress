# Instruction: How to Validate the Ingress Changes

## Prerequisites

Make sure you have the following tools installed:
- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

## Steps

### 1. Create the cluster

```bash
kind create cluster --config cluster.yml
```

### 2. Bootstrap the cluster (deploy the app and install the ingress controller)

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Wait until all pods are running:

```bash
kubectl get pods -n todoapp
kubectl get pods -n mysql
```

### 3. Deploy the Ingress manifest

```bash
kubectl apply -f infrastructure/ingress/ingress.yml
```

Verify the Ingress was created:

```bash
kubectl get ingress -n todoapp
```

### 4. Wait for the ingress controller to become ready

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

### 5. Validate the app is accessible

Open your browser and navigate to:

```
http://localhost
```

You should see the ToDo application running.

### 6. Verify no 404 errors

1. Open the browser **Developer Tools** (F12 or Cmd+Option+I).
2. Go to the **Network** tab.
3. Reload the page (`Ctrl+R` / `Cmd+R`).
4. Confirm that **no requests return a 404 status code**.

### 7. Quick smoke test via curl

```bash
# Should return 200 OK
curl -o /dev/null -s -w "%{http_code}\n" http://localhost

# Should return 200 OK for the API
curl -o /dev/null -s -w "%{http_code}\n" http://localhost/api/

# Health check
curl -o /dev/null -s -w "%{http_code}\n" http://localhost/api/health
```

All three commands should print `200`.

---

## Teardown

To delete the cluster when done:

```bash
kind delete cluster
```