# Task 10: Ingress

## Requirements

- Docker Desktop
- kind
- kubectl
- Git Bash (or any bash shell)

## How to run

1. Create the kind cluster and deploy everything (MySQL, the app, the ingress-nginx controller and the Ingress):

```bash
bash bootstrap.sh
```

The script takes a few minutes. It creates the kind cluster (3 nodes, ports 80 and 443 are mapped to the control-plane node), applies the MySQL and app manifests, installs the ingress-nginx controller for kind, waits until it is ready, pins it to the control-plane node (label `ingress-ready=true`), waits 20 seconds for the admission webhook and then applies `./infrastructure/ingress/ingress.yml`.

## How to validate

1. All pods are Running:

```bash
kubectl get pods -A
```

2. The Ingress exists:

```bash
kubectl get ingress -n todoapp
```

3. The app answers through the Ingress (expected `HTTP/1.1 200 OK`):

```bash
curl -i http://localhost
```

4. Open http://localhost in the browser. The Todo page is shown and there are no 404 errors in the browser console (F12 -> Console).
5. Open http://localhost/api/ . The Django REST framework API root is shown with `users`, `todolists` and `todos`.

## Notes

- The Ingress uses `ingressClassName: nginx`, `use-regex: "true"` and `rewrite-target: /$1` with the path `/(.*)`, and sends all traffic to `todoapp-service` on port 80.
- The controller is pinned to the control-plane node, because only this node has the host ports 80/443 mapped by kind. Without it the controller can start on a worker node and `curl` fails with an empty response.
- The `sleep 20` in `bootstrap.sh` gives the admission webhook of the controller time to start; otherwise the first `kubectl apply` of the Ingress can fail with "connection refused".
- Passwords in the Secrets are demo values for a local cluster only.

