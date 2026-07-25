# ToDo App — Ingress Instructions

## Prerequisites

- `kind` installed (https://kind.sigs.k8s.io/)
- `kubectl` installed and configured
- Docker running locally

## 1. Create the cluster

Spin up a local Kubernetes cluster using `kind` and the provided
configuration file:

```bash
kind create cluster --config cluster.yml
```

Verify the cluster is up:

```bash
kubectl cluster-info --context kind-kind
```

## 2. Deploy the app and the ingress controller

Run the bootstrap script, which deploys the application and installs the
NGINX ingress controller:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Wait for the ingress controller pod to become ready:

```bash
kubectl get pods -n ingress-nginx --watch
```

Press `Ctrl+C` once the controller pod shows status `Running` and `1/1 Ready`.

## 3. Deploy the Ingress resource

```bash
kubectl apply -f infrastructure/ingress/ingress.yml
```

Confirm the Ingress was created:

```bash
kubectl get ingress -n todoapp
```

## 4. Validate the app is accessible

Open your browser and navigate to:

http://localhost

You should see the ToDo app landing page load correctly.

## 5. Validate there are no 404 errors

Open your browser's Developer Tools (F12) and go to the **Network** tab,
then reload the page.

Confirm that:
- All requests (HTML, CSS, JS, and API calls) return successful status
  codes (2xx), not 404.
- Navigating to other app routes, such as http://localhost/auth/login/,
  loads the correct page content (not just the header/landing page).

## 6. Validate the Ingress configuration

Describe the Ingress resource to confirm the rule and path configuration:

```bash
kubectl describe ingress todoapp-nginx-ingress -n todoapp
```

Confirm it shows:
- One HTTP rule
- One path-based rule routing to the `todoapp-service` on port `80`

## Cleaning up

```bash
kind delete cluster
```