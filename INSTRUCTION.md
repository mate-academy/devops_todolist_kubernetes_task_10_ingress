# Instruction: How to Validate the Changes

## Prerequisites

Make sure you have the following tools installed:
- [Docker](https://www.docker.com/)
- [kind](https://kind.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

## Steps to Run and Validate

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd devops_todolist_kubernetes_task_10_ingress
```

### 2. Create the cluster
```bash
kind create cluster --config cluster.yml
```

### 3. Deploy the app and install the Ingress controller
```bash
bash bootstrap.sh
```

### 4. Apply the Ingress manifest
```bash
kubectl apply -f infrastructure/ingress/ingress.yml
```

### 5. Verify the Ingress was created
```bash
kubectl get ingress
```
You should see `todolist-ingress` in the list.

### 6. Check that all pods are running
```bash
kubectl get pods
```
All pods should have the status `Running`.

---

## Validation

### ✅ App is accessible
1. Open your browser and go to `http://localhost`
2. Confirm that the ToDo app UI appears correctly (task list, input field, etc.)

### ✅ No 404 errors
1. Open **DevTools** in your browser (`F12`)
2. Go to the **Network** tab
3. Reload the page (`Cmd+R` or `Ctrl+R`)
4. Check all requests — all app/API/static requests should return `2xx` or `3xx` status codes
5. There should be **no requests with a `404` status code**

### ✅ Ingress has correct rules
```bash
kubectl describe ingress todolist-ingress
```
You should see 1 HTTP rule with 1 path-based rule routing `/` to the app.