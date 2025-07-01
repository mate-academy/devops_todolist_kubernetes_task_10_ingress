# How to validate ingress

1. Make sure the ingress controller is running:
   ```sh
   kubectl get pods -A | grep ingress-nginx
   ```
   You should see at least one ingress-nginx-controller pod in the `Running` state.

2. Apply your ingress manifest:
   ```sh
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

3. Check that the ingress resource is created:
   ```sh
   kubectl get ingress -A
   ```
   You should see your `todoapp-ingress` listed.

4. Open your browser and go to [http://localhost/](http://localhost/).
   You should see your app's web page.

5. If you see a 404 or 503 error:
   - check that your service and deployment are running and healthy:
     ```sh
     kubectl get pods -n todoapp
     kubectl get svc -n todoapp
     ```
   - check ingress events for errors:
     ```sh
     kubectl describe ingress -n todoapp todoapp-ingress
     ```
