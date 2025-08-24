Ingress Validation Instructions
Prerequisites

Docker installed and running
Kind installed
kubectl installed

Deployment Steps

Run bootstrap script:
bashchmod +x bootstrap.sh
./bootstrap.sh


Validation Steps
1. Verify Cluster Status
bashkubectl get nodes
2. Verify Ingress Controller
bashkubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
3. Verify Application Deployment
bashkubectl get deployments
kubectl get services
kubectl get pods
4. Verify Ingress Configuration
bashkubectl get ingress
kubectl describe ingress todoapp-ingress
5. Test Application Access
bash# Check if ingress is ready
kubectl wait --for=condition=Ready --timeout=300s ingress/todoapp-ingress

# Test HTTP access
curl -H "Host: localhost" http://localhost
6. Browser Validation

Open browser and go to http://localhost
Verify application loads successfully
Check browser console for any 404 errors
Navigate through different app sections to test path routing

7. Test Path-Based Routing
bash# Test root path
curl -H "Host: localhost" http://localhost/

# Test API paths (if available)
curl -H "Host: localhost" http://localhost/api/health

# Test static assets
curl -H "Host: localhost" http://localhost/static/
8. Check Ingress Logs
bashkubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller
Expected Results

 Application accessible at http://localhost
 No 404 errors in browser console
 All paths properly routed to application
 Ingress controller running and healthy

Troubleshooting
If application not accessible:
bash# Check ingress status
kubectl get ingress -o yaml

# Check service endpoints
kubectl get endpoints

# Check pod logs
kubectl logs -l app=todoapp
If 404 errors occur:
bash# Check nginx ingress logs
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller --tail=50

# Verify service name and port in ingress
kubectl get svc
Cleanup
bashkind delete cluster --name ingress-cluster