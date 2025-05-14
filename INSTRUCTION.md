# Ingress Configuration Validation Instructions

## Steps to Validate Ingress Configuration

1. Apply the ingress configuration:
   ```bash
   kubectl apply -f infrastructure/app/ingress.yml
   ```

2. Verify the ingress is created and running:
   ```bash
   kubectl get ingress
   ```

3. Test the application access:
   - Open your web browser and navigate to `http://localhost`
   - The application should load successfully

4. Verify path-based routing:
   - Try accessing different paths like `http://localhost/api` or `http://localhost/static`
   - All requests should be properly routed to the application

5. Check ingress logs for any issues:
   ```bash
   kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
   ```