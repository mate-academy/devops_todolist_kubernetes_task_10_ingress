# Kubernetes Ingress Configuration

## 1. How to deploy all resources
Run the provided bootstrap script. It will deploy the database, the application, install the NGINX Ingress Controller, and finally apply the Ingress routing rules.
```bash
sh bootstrap.sh
```
*Note: The Ingress Controller pods may take a minute to become fully ready after the script finishes.*

## 2. Architecture & Best Practices Rationale
The Ingress setup satisfies the task requirements while acknowledging modern K8s networking realities:
* **Regex Path Capturing & 404 Prevention:** We use `pathType: ImplementationSpecific` with the `/(.*)` regex and the `rewrite-target: /$1` annotation. This captures the path and forwards it exactly as is. Without this, Django would fail to resolve nested routes (like `/static/...`), resulting in `404 Not Found` errors.
* **Cost Efficiency:** Instead of provisioning an expensive Cloud LoadBalancer for every microservice, this architecture uses a single Ingress Controller as the cluster's "entry door", efficiently routing traffic to internal `ClusterIP` services based on paths.
* **Future-Proofing (Gateway API):** While this task relies on standard Ingress, we recognize that Ingress is prone to "annotation hell" (heavily relying on `metadata.annotations` for routing logic like regex). In a modern enterprise scenario (2024+), we would migrate to the **Gateway API** (GatewayClass, Gateway, HTTPRoute) for more granular and expressive traffic management.

## 3. How to validate the changes

### Step A: Verify Ingress Resource
Check that the Ingress was created successfully and the NGINX controller is running:
```bash
kubectl get ingress todoapp-ingress -n mateapp
```

### Step B: Validate App Accessibility
1. Open your web browser and navigate to: `http://localhost`
2. You should see the ToDo application running successfully via the default HTTP port 80.

### Step C: Validate No 404 Errors (Static Files)
1. On the application page (`http://localhost`), open the Developer Tools (`F12` or right-click -> `Inspect`).
2. Navigate to the **Network** or **Console** tab.
3. Refresh the page (`F5`).
4. Verify that there are absolutely no `404 Not Found` errors. All CSS and JavaScript files must load with a `200 OK` status, proving the regex path rule successfully forwards static file requests to the Django app.