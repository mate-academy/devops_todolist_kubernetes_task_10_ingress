# Validating the Ingress Changes

This document explains how to deploy and validate `infrastructure/ingress/ingress.yml`,
which exposes the `todoapp` on `http://localhost/`.

## What changed and why

The original manifest had two problems:

1. **Broken YAML indentation** — the `nginx.ingress.kubernetes.io/use-regex` annotation
   was indented at the same level as the `annotations:` key itself, which is invalid
   YAML (the key needs to be nested one level deeper). This has been fixed.
2. **Missing rewrite rule** — the path `/(.*)` captures everything after `/` into a
   regex group, but nothing told NGINX to forward that captured group to the backend.
   Without a rewrite, the raw unrewritten path (or the literal `/(.*)` semantics) is
   sent to the service, which causes the app to 404 on every asset/route. Added:
   ```yaml
   nginx.ingress.kubernetes.io/rewrite-target: /$1
   ```
   This tells NGINX to replace the matched request path with the first capture
   group `$1` from `path: /(.*)` before forwarding to `todoapp-service`, so
   `http://localhost/` and any sub-paths resolve correctly against the app.

## Prerequisites

- A local Kubernetes cluster (e.g. `kind`, `minikube`, or Docker Desktop Kubernetes)
- `kubectl` configured against that cluster
- The NGINX Ingress Controller installed in the cluster
- The `todoapp` Deployment/Service already applied in the `todoapp` namespace,
  exposing port 80 via a Service named `todoapp-service`

If the NGINX ingress controller isn't installed yet:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

For `kind` clusters, use the `kind`-specific manifest instead:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Wait for the controller to be ready:

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

## Steps to validate

1. **Ensure the namespace and app exist**

   ```bash
   kubectl get ns todoapp
   kubectl get deploy,svc -n todoapp
   ```

   You should see `todoapp-service` listed and healthy.

2. **Apply the Ingress**

   ```bash
   kubectl apply -f infrastructure/ingress/ingress.yml
   ```

3. **Confirm the Ingress resource was created correctly**

   ```bash
   kubectl get ingress -n todoapp
   kubectl describe ingress todoapp-ingress -n todoapp
   ```

   Confirm:
   - There is exactly **1 rule**, using HTTP, with path `/(.*)` and `pathType: Prefix`
   - The rule's backend is `todoapp-service:80`
   - The `ADDRESS` column is populated (may take a few seconds)

4. **Expose the ingress controller on localhost** (skip if your cluster already
   maps the ingress controller's LoadBalancer/NodePort to `localhost:80`, e.g. `kind`
   with `extraPortMappings`, or Docker Desktop):

   ```bash
   kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 80:80
   ```

5. **Open the app in a browser**

   Navigate to `http://localhost` (or `http://localhost/` and a few in-app routes).

   - The app should load and function normally.
   - Open the browser DevTools → **Network** tab and confirm no requests return
     a **404** status code (page loads, static assets, and any API calls should
     all succeed).

6. **Command-line sanity check (optional, in addition to the browser check)**

   ```bash
   curl -i http://localhost/
   ```

   Expect an HTTP `200` response with the app's HTML body.

## Rollback

If something goes wrong, remove the Ingress with:

```bash
kubectl delete -f infrastructure/ingress/ingress.yml
```

## Opening a Pull Request

1. Create a branch and commit the changes:

   ```bash
   git checkout -b fix/todoapp-ingress
   git add infrastructure/ingress/ingress.yml INSTRUCTION.md
   git commit -m "Fix todoapp ingress: correct annotation indentation and add rewrite-target"
   git push origin fix/todoapp-ingress
   ```

2. Open a PR against the default branch (e.g. via the GitHub UI, or the CLI):

   ```bash
   gh pr create --title "Fix todoapp ingress routing" \
     --body "Fixes invalid annotation indentation and adds rewrite-target so /(.*) paths route correctly to todoapp-service, eliminating 404s on http://localhost."
   ```

3. Attach/link the PR for validation on your team's platform (e.g. paste the PR
   URL in the relevant ticket or review channel) and follow the validation steps
   above in the reviewer's environment or CI.