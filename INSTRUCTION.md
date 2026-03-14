# Validation Instructions

1. Create the local Kubernetes cluster:

```bash
kind create cluster --config cluster.yml
```

2. Deploy the application stack and ingress controller:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

3. Confirm that the workload is healthy:

```bash
kubectl get pods -A
kubectl get svc -n todoapp
kubectl get ingress -n todoapp
```

4. Wait until the `todoapp` pod is `Running` and the ingress controller pod in `ingress-nginx` is `Running`.

5. Open the application in a browser:

```bash
open http://localhost
```

6. Validate the ingress behavior:
   - the app homepage loads on `http://localhost`
   - navigation to pages such as `http://localhost/auth/login/` and `http://localhost/api/` works
   - browser DevTools console does not show failed `404` requests

7. Optional CLI check:

```bash
curl -I http://localhost
curl -I http://localhost/api/health
```

Both requests should return a successful HTTP status.
