### Ingress Validation

1. **Check Ingress Resource:**
Verify that the Ingress rule was successfully created in the cluster:
```bash
kubectl get ingress
```

2. Test Routing via Terminal:
Send a request to the localhost from your host machine to ensure the Ingress controller routes traffic to the app:

```Bash
curl -I http://localhost
```

3. Browser Test:

Open `http://localhost` in your web browser. The ToDo application should load successfully without any 404 errors in the developer console.