# Validation Instructions

These steps verify that the ToDo app is reachable through `http://localhost` via the
new `Ingress` resource, with no failing (404) requests.

## Prerequisites

- Docker running locally
- `kind` installed
- `kubectl` installed

## 1. Create the cluster

From the repo root:

```bash
kind create cluster --config .infrastructure/cluster.yml
```

Confirm the cluster and nodes are up:

```bash
kubectl cluster-info
kubectl get nodes
```

You should see 1 control-plane node and 2 worker nodes, all `Ready`.

## 2. Run the bootstrap script

```bash
chmod +x .infrastructure/bootstrap.sh
./.infrastructure/bootstrap.sh
```

This will, in order:

1. Deploy the `mysql` namespace, secrets, config, headless service and `StatefulSet`.
2. Deploy the `todoapp` namespace, PV/PVC, secret, config, `ClusterIP`/`NodePort`
   services, `HorizontalPodAutoscaler` and `Deployment`.
3. Install the `ingress-nginx` controller for `kind`.
4. Wait for the `ingress-nginx` controller pod to become `Ready`.
5. Apply `.infrastructure/ingress/ingress.yml`.

## 3. Confirm everything is running

```bash
kubectl get pods -n mysql
kubectl get pods -n todoapp
kubectl get pods -n ingress-nginx
kubectl get ingress -n todoapp
```

- All pods should be `Running`/`1/1` or `2/2` ready.
- `kubectl get ingress -n todoapp` should show `todoapp-ingress` with an address
  assigned and host `*` (no host restriction), path `/(.*)`.

If the app pods are not becoming `Ready`, check logs:

```bash
kubectl logs -n todoapp deploy/todoapp
kubectl logs -n mysql mysql-0
```

## 4. Access the app

Open a browser at:

```
http://localhost
```

You should see the ToDo app landing page load successfully.

Open the browser DevTools **Network** tab and reload the page. Confirm:

- The main document (`/`) returns **200**.
- All static assets (CSS/JS from Skeleton/jQuery, and any app-bundled assets)
  return **200**, not **404**.
- Any API calls made by the UI (e.g. `/api/...`) return **200**
  (or an expected non-404 status such as `401` if unauthenticated), not **404**.

You can also check the API directly:

```bash
curl -i http://localhost/api/
```

This should return a valid JSON/HTML response (DRF browsable API or JSON), not a 404.

## 5. Verify routing/rewrite behavior

The Ingress uses a regex capture on the path (`/(.*)`) together with
`nginx.ingress.kubernetes.io/rewrite-target: /$1`, so every request under `/`
is forwarded to the app on the equivalent path (the captured group). Confirm a
few different paths all resolve correctly and none produce 404s from the
ingress layer:

```bash
curl -i http://localhost/            # landing page
curl -i http://localhost/api/        # API root
```

## 6. Tear down (optional)

```bash
kind delete cluster --name kind
```

## Summary of what to check for a passing validation

- [ ] `kind` cluster comes up from `.infrastructure/cluster.yml` with 1 control-plane + 2 workers
- [ ] `bootstrap.sh` completes without errors
- [ ] All pods in `mysql` and `todoapp` namespaces reach `Running`/`Ready`
- [ ] `ingress-nginx-controller` pod is `Ready` before the Ingress is applied
- [ ] `kubectl get ingress -n todoapp` shows `todoapp-ingress` with 1 rule, 1 path (`/(.*)`) targeting `todoapp-service:80`
- [ ] `http://localhost` loads the ToDo app in the browser
- [ ] No requests in the browser Network tab return 404
