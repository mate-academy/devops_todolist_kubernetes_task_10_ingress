# How to validate changes
 
1. Create Kind cluster: kind create cluster --config cluster.yml 
2. Run bootstrap script: ./bootstrap.sh 
3. Apply Ingress: kubectl apply -f ./infrastructure/ingress/ingress.yml 
4. Check all pods: kubectl get pods -A 
5. Open browser at http://localhost/ and verify the app is running. 
6. Verify that there are no 404 requests in browser console.