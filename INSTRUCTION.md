# Validation Instructions
## Prerequisites
- kind cluster running
- kubectl installed
- ingress controller deployed


## Validation Steps
1. **Apply ingress:**
   ```bash
   kubectl apply -f ./infrastructure/ingress/ingress.yml


Check ingress status:
kubectl get ingress


Test access:
curl http://localhost


Verify in browser:

Open http://localhost
Check browser console for 404 errors
App should load without 404 errors


