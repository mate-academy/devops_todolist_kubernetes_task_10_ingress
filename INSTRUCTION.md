# Task 10 — Kubernetes Ingress: validation instructions

## Prerequisites

- Docker Desktop, `kind`, `kubectl`, and `curl` are installed.
- The repository is cloned locally.
- Run the commands below from the repository root.
- The example uses the Kubernetes context `kind-task10`.

## 1. Create the Kubernetes cluster

```bash
kind create cluster --name task10 --config cluster.yml
kubectl config use-context kind-task10
kubectl get nodes
```

All nodes should eventually report `Ready`. If the cluster already exists, skip the `kind create cluster` command and verify the context.

The provided `cluster.yml` maps the host's HTTP port 80 to port 80 of the kind control-plane container. Ensure the port is available on the host.

## 2. Deploy the application and Ingress Controller

```bash
bash bootstrap.sh
kubectl get pods -A
```

Verify that the ToDo application in the `todoapp` namespace and the NGINX Ingress Controller in the `ingress-nginx` namespace are running:

```bash
kubectl get pods -n todoapp
kubectl get pods -n ingress-nginx
kubectl get svc -n todoapp
```

## 3. Ensure the Ingress Controller runs on the control-plane node

The provided `cluster.yml` publishes ports `80` and `443` from the **`task10-control-plane`** container to the host. Because this setup uses the NGINX controller's `hostPort: 80` and `hostPort: 443`, the controller must run on that node for `http://localhost/` to work. Kubernetes may otherwise schedule it on a worker node.

After installing the controller, pin its Deployment to the control-plane node:

```bash
kubectl patch deployment ingress-nginx-controller \
  -n ingress-nginx \
  --type=merge \
  -p '{"spec":{"template":{"spec":{"nodeSelector":{"kubernetes.io/hostname":"task10-control-plane"}}}}}'
kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx
kubectl get pods -n ingress-nginx -o wide
```

The controller Pod should have `NODE` set to `task10-control-plane`. This step is necessary **unless** the repository's bootstrap procedure already pins the controller to that node. A live `kubectl patch` is not persistent if the cluster is deleted and recreated, so repeat it after installing the controller in a fresh cluster or automate it in `bootstrap.sh`.

## 4. Deploy the Ingress resource

The Ingress manifest for this repository should be committed at `.infrastructure/ingress/ingress.yml` (matching the existing `.infrastructure` repository layout and the path referenced in `bootstrap.sh`). If the file was initially created at `.infrastructure/ingress/ingress.yml`, move it to the intended directory before submitting. Note: the task README uses `./infrastructure/ingress/` without the leading dot; verify the final directory convention expected by the validator.

```bash
kubectl apply -f .infrastructure/ingress/ingress.yml
kubectl get ingress -n todoapp
kubectl describe ingress todo-ingress -n todoapp
```

Validate that the Ingress has **one HTTP rule** and **one path-based rule** covering `/`, with regex capture and URL rewriting. The backend should reference `todoapp-service` on port `80`. The Ingress class should be `nginx`.

Example of the expected path and NGINX annotations:

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

Verify the main page over the mapped host port:

```bash
curl -v http://localhost/
```

Expected result: an HTTP `200 OK` response with the ToDo application HTML. Open **http://localhost/** in a browser.

Open browser Developer Tools → **Network**, reload the page, and check that application requests, especially `/static/css/custom.css`, `/static/js/site.js`, and `/static/images/favicon.png`, do **not** return HTTP `404`.

To check individual resources from the terminal:

```bash
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/css/custom.css
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/js/site.js
curl -o /dev/null -s -w '%{http_code}\n' http://localhost/static/images/favicon.png
```

## 6. Troubleshooting

If `http://localhost/` does not respond, first check the Ingress rule and endpoints:

```bash
kubectl describe ingress todo-ingress -n todoapp
kubectl get endpoints todoapp-service -n todoapp
kubectl get pods -n ingress-nginx -o wide
```

Check whether Docker has mapped port 80:

```bash
docker ps --format 'table {{.Names}}\t{{.Ports}}'
lsof -nP -iTCP:80 -sTCP:LISTEN
```

To test the app separately from Ingress:

```bash
kubectl port-forward -n todoapp svc/todoapp-service 8080:80
# In another terminal: curl -v http://127.0.0.1:8080/
```

To test Ingress routing while bypassing the kind host port mapping:

```bash
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8081:80
# In another terminal: curl -v http://127.0.0.1:8081/
```

If the second test returns `200 OK` but `http://localhost/` returns `Empty reply from server`, the Ingress resource and backend routing work; investigate host-to-kind port forwarding or the controller's binding on the kind control-plane node.

If the HTML loads but static files return `404`, verify the NGINX regex, rewrite annotation and Django static file routes. Do not consider validation complete until the browser Network panel has no failing `404` requests.

## 7. Submission

Commit `ingress.yml` and `INSTRUCTION.md`. Prefer updating `bootstrap.sh` to wait for the controller, apply the node placement setting described in section 3, wait for its rollout, and apply `ingress.yml` automatically. The original `bootstrap.sh` leaves the Ingress application command commented out, so that step otherwise remains manual. Push your branch, open a Pull Request and submit its link on the learning platform.

**Observed troubleshooting outcome:** Initially `http://127.0.0.1:8081/` returned `200 OK` using `kubectl port-forward`, but `http://localhost/` returned an empty reply because the controller Pod had been scheduled on `task10-worker2`. Pinning the controller to `task10-control-plane` resolved the issue, and access via `localhost` subsequently worked. The reviewer should repeat the HTTP and browser Network checks after their own deployment.
