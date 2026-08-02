# Validation

1. Create the kind cluster:

```bash
kind create cluster --config cluster.yml
```

2. Run the bootstrap script to deploy the application and install the Ingress Controller:

```bash
./bootstrap.sh
```

3. Check that the application pods are running:

```bash
kubectl get pods -n todoapp
```

All application pods should have the `Running` status and be ready.

4. Check that the application service exists:

```bash
kubectl get services -n todoapp
```

The `todoapp-nodeport` service should be displayed.

5. Check that the Ingress resource was created:

```bash
kubectl get ingress -n todoapp
```

The `mate-ingress` resource should be displayed.

6. Open the application in a browser:

```text
http://localhost
```

The ToDo application should be displayed.

7. Open the browser developer tools and check the `Console` and `Network` tabs.

There should be no failed requests with the `404 Not Found` status code.