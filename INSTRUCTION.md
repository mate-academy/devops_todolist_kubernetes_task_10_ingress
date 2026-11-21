# Task 10 — Kubernetes Ingress: Validation Instructions

## Prerequisites

- Docker Desktop, `kind`, `kubectl`, and `curl` are installed.
- The repository is cloned locally.
- Run all commands from the repository root.
- This example uses a kind cluster named `task10` and Kubernetes context `kind-task10`.
- Port 80 on your host is available.

## 1. Create the Kubernetes cluster

```bash
kind create cluster --name task10 --config cluster.yml
kubectl config use-context kind-task10
kubectl get nodes
```

All nodes should eventually report `Ready`. If the cluster already exists, skip `kind create cluster` and verify the active context.

The provided `cluster.yml` maps host port 80 to port 80 of the `task10-control-plane` container.

## 2. Deploy the application and Ingress Controller

```bash
bash bootstrap.sh
kubectl get pods -A
```

Verify the ToDo app in namespace `todoapp`, NGINX Ingress Controller in namespace `ingress-nginx`, and the app Service:

```bash
kubectl get pods -n todoapp
kubectl get pods -n ingress-nginx
kubectl get svc -n todoapp
```

## 3. Verify Ingress Controller node placement

The cluster maps ports 80 and 443 from `task10-control-plane` to the host. The NGINX Ingress Controller uses `hostPort: 80` and `hostPort: 443`, so its Pod must run on `task10-control-plane` for `http://localhost/` to work through these mappings.

The updated `bootstrap.sh` should patch the controller Deployment to select `task10-control-plane` and wait for rollout completion. Confirm placement:

```bash
kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx --timeout=180s
kubectl get pods -n ingress-nginx -o wide
```

The controller Pod should show `task10-control-plane` in the `NODE` column.

If your bootstrap script does **not** configure placement, use the following commands after installing the controller:

```bash
kubectl patch deployment ingress-nginx-controller \
  -n ingress-nginx \
  --type=merge \
  -p '{"spec":{"template":{"spec":{"nodeSelector":{"kubernetes.io/hostname":"task10-control-plane"}}}}}'
kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx --timeout=180s
```

The command above assumes a cluster named `task10`; if you use another cluster name, update the hostname accordingly. To make the fix reproducible after recreating the cluster, include the controller placement step in `bootstrap.sh`.

## 4. Deploy and inspect the Ingress resource

**Required manifest location:** `./infrastructure/ingress/ingress.yml` (the `infrastructure` directory has **no leading dot**).

The repository also contains a separate `.infrastructure/` directory for the existing app and MySQL manifests. Keep those files in their original locations. The Ingress manifest belongs in `infrastructure/ingress/`, as specified by the task README.

The updated `bootstrap.sh` should apply the Ingress automatically. You can also apply it explicitly:

```bash
kubectl apply -f ./infrastructure/ingress/ingress.yml
kubectl get ingress -n todoapp
kubectl describe ingress todo-ingress -n todoapp
```

Verify one HTTP rule and one path-based rule covering `/`, including regex capture and rewriting. The backend must be `todoapp-service` on port `80`, and the Ingress class should be `nginx`.

The relevant routing configuration is:

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  ingressClassName: nginx
  rules:
    - http:
        paths:
          - path: /()(.*)
            pathType: ImplementationSpecific
            backend:
              service:
                name: todoapp-service
                port:
                  number: 80
```

## 5. Validate application access

Check the main page through the required host URL:

```bash
curl -v http://localhost/
```

Expected result: `HTTP/1.1 200 OK` and the ToDo application HTML. Open **http://localhost/** in a browser.

Open browser Developer Tools → **Network**, reload the page, and make sure requests do **not** fail with HTTP `404`. In particular, check these static assets:

```bash
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/css/custom.css
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/js/site.js
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/images/favicon.png
```

These resources should return successful HTTP responses (normally `200`); verify the browser Network tab as well.

## 6. Troubleshooting

If `http://localhost/` does not respond, inspect the Ingress rule, app Service endpoints, and controller placement:

```bash
kubectl describe ingress todo-ingress -n todoapp
kubectl get endpoints todoapp-service -n todoapp
kubectl get pods -n ingress-nginx -o wide
```

Check host port mapping:

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
lsof -nP -iTCP:80 -sTCP:LISTEN
```

To check the app without Ingress, start the following command in one terminal:

```bash
kubectl port-forward -n todoapp svc/todoapp-service 8080:80
```

In a second terminal:

```bash
curl -v http://127.0.0.1:8080/
```

To test NGINX Ingress routing while bypassing the kind host port mapping, run:

```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8081:80
```

In another terminal:

```bash
curl -v http://127.0.0.1:8081/
```

If `http://127.0.0.1:8081/` returns `200 OK` but `http://localhost/` gives an empty response, the application and Ingress routing are operational through the tunnel; check `task10-control-plane` host-port binding and controller node placement.

If the main HTML loads but static files return `404`, inspect the Ingress regex, rewrite annotation, and Django static file routes. Validation is not complete until the browser Network tab shows no failing `404` requests.

## 7. Submission

Confirm the following changed files are tracked in Git:

- `infrastructure/ingress/ingress.yml`
- `INSTRUCTION.md`
- `bootstrap.sh` (updated to configure controller placement and apply the Ingress)

Commit the changes, push the branch, create or update the Pull Request, and submit its URL to the learning platform.

**Observed during troubleshooting:** `http://127.0.0.1:8081/` returned `200 OK` through `kubectl port-forward`, while `http://localhost/` initially failed because the controller Pod was on `task10-worker2`. Scheduling the controller on `task10-control-plane` resolved the problem. Reviewers should repeat the HTTP and browser Network tests in their own environment.
