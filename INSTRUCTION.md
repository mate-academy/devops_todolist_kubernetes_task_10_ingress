# Validation Instructions

## Prerequisites

- `kind` cluster running
- All resources deployed via `bootstrap.sh`

## Steps

1. **Create the kind cluster:**
   ```bash
   kind create cluster --name todoapp --config cluster.yml
   ```

2. **Load the Docker image (if not already available):**
   ```bash
   kind load docker-image ikulyk404/todoapp:4.0.1 --name todoapp
   ```

3. **Deploy all resources:**
   ```bash
   bash bootstrap.sh
   ```

4. **Verify ingress controller is running:**
   ```bash
   kubectl get pods -n ingress-nginx
   ```

5. **Verify ingress resource:**
   ```bash
   kubectl get ingress -n todoapp
   kubectl describe ingress todoapp-ingress -n todoapp
   ```

6. **Access the app:**
   ```bash
   curl -s -o /dev/null -w '%{http_code}' http://localhost
   ```
   Open browser at `http://localhost` — the Django ToDo app landing page should load.

7. **Check for 404 errors:**
   ```bash
   curl -s -o /dev/null -w '%{http_code}' http://localhost/static/css/skeleton.css
   curl -s -o /dev/null -w '%{http_code}' http://localhost/api/health
   ```
   Open browser DevTools (F12) → Console tab. There should be no requests failing with 404 status.

## Cleanup

```bash
kind delete cluster
```
