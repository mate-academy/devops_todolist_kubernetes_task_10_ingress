# ToDo App with Ingress

This configuration exposes the application on `http://localhost` (port 80) using an NGINX Ingress Controller.

## 1. Cluster Setup
Since Ingress requires port mapping, recreate the cluster using the updated config:

```
kind delete cluster
kind create cluster --config cluster.yml
```
## 2. Deployment
Run the bootstrap script, which now includes the Ingress Controller installation:

```
chmod +x bootstrap.sh
./bootstrap.sh
```
## 3. Validation
### 1. Check Ingress Resource Ensure the Ingress is created and has an address (it might take a minute to get an Address, usually localhost or empty in Kind, but port 80 works).

```
kubectl get ingress -n mateapp
```
2. Verify Access Open your browser and navigate to: http://localhost

You should see the ToDo App landing page.

Crucial: Check the Browser Console (F12). There should be no 404 errors for static files (CSS/JS). If styles are loading, the regex rewrite is working correctly.

3. Test Functionality Try logging in or creating a task to ensure the API routing works through Ingress.