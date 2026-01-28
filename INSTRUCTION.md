# Validation Instructions

## Steps

1. Create the Kind cluster:

   ```
   kind create cluster --config cluster.yml
   ```

2. Deploy the application and ingress controller:

   ```
   ./bootstrap.sh
   ```

3. Apply the Ingress manifest:

   ```
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

4. Verify resources are ready:

   ```
   kubectl get pods -n todoapp
   kubectl get ingress -n todoapp
   ```

5. Open the app in a browser:
   - http://localhost

6. Confirm no 404 errors in the browser console.
