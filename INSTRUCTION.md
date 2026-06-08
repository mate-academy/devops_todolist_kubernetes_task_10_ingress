# How to validate Ingress changes

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Deploy the cluster and application

1. Create a kind cluster from the project configuration:

   ```bash
   kind create cluster --config cluster.yml
   ```

2. Deploy the application and install the ingress controller:

   ```bash
   bash bootstrap.sh
   ```

3. Apply the Ingress manifest:

   ```bash
   kubectl apply -f .infrastructure/ingress/ingress.yml
   ```

4. Wait until all pods are ready:

   ```bash
   kubectl get pods -A
   ```

   Ensure pods in `todoapp`, `mysql`, and `ingress-nginx` namespaces are in the `Running` state.

## Validate the Ingress

1. Open the application in a browser:

   ```
   http://localhost
   ```

2. Confirm that the ToDo list landing page loads successfully.

3. Open the browser developer tools (Network tab) and refresh the page.

4. Verify that there are no failed requests with the `404` status code (especially for static assets such as CSS and JS files).

5. Optionally, validate from the terminal:

   ```bash
   curl -I http://localhost
   ```

   Expected response: HTTP status `200` or `302` (redirect to login page).

6. Check that the Ingress resource is configured correctly:

   ```bash
   kubectl get ingress -n todoapp
   kubectl describe ingress todoapp-ingress -n todoapp
   ```

## Cleanup

Remove the local kind cluster when validation is complete:

```bash
kind delete cluster
```
