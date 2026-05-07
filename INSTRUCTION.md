## Validating solution:
1. Port-forward ingress-nginx-controller to port on local machine
    ```
   kubectl -n ingress-nginx port-forward service/ingress-nginx-controller 8081:80
   ```
2. Get http request: http://localhost:8081