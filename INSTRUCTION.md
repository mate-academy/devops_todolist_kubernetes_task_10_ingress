# Preparation

Before validation, deploy all required Kubernetes resources using the `bootstrap.sh` script.

Make the script executable:

```bash
chmod +x bootstrap.sh
```

Run the script from the root directory of the repository:

```bash
./bootstrap.sh
```

# Validation

## Verify the Ingress Controller

Run:

```bash
kubectl get all -n ingress-nginx
```

The `ingress-nginx-controller` Pod should be in the `Running` state, and the Deployment should show one available replica.

## Verify the Ingress resource

Run:

```bash
kubectl get ingress
```

For more details, run:

```bash
kubectl describe ingress todoapp-ingress
```

## Verify the application

Open the following URL in a browser:

```text
http://localhost
```

The application should load without specifying a port.

Open the browser developer console and make sure that there are no requests returning a `404` status code.