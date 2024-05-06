# How to validate the changes

1. Run Bootstrap Script

```bash
./bootstrap.sh
```

2. Verify Deployment

```bash
kubectl get all -n todoapp
kubectl get all -n mysql
```

3. Check Ingress resource:

```bash
kubectl get ingress -n todoapp
```

4. Validation
   To validate the changes, follow these steps:
   1. Access the application via http://localhost.
   2. Check for successful page load without any 404 errors in the browser console.
   3. Verify that the path is being captured and forwarded to the application as expected.
