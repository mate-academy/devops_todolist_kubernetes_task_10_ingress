# Instructions for Validating Kubernetes Ingress Changes

Follow these steps to ensure the application is correctly deployed and accessible via the Ingress controller.

---

## 1. Verify Cluster and Resources
Before testing the URL, ensure all components are running in their respective namespaces:
* Check application pods: `kubectl get pods -n todoapp` 
* Check ingress status: `kubectl get ingress -n todoapp` 
* Ensure the Ingress controller is active: `kubectl get pods -n ingress-nginx` 

## 2. Establish Local Access (Port-Forwarding)
Since the environment is running on `kind` (Windows/MSYS), you must manually map the local port to the Ingress controller:
```bash
kubectl port-forward service/ingress-nginx-controller 80:80 -n ingress-nginx
```
Note: Keep this terminal window open during testing. 
If port 80 is occupied by another process, use 8080:80 and access the app via http://localhost:8080.

## 3. Web Browser Validation
* Open your preferred web browser.
* Navigate to: http://localhost
* Expected Result: You should see the "Dead simple Todolists" landing page rendered correctly.