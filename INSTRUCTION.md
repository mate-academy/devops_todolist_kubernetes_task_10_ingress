### Exec in your terminal
```bash
./bootstrap.sh
kubectl apply -f .infrastructure/ingress/ingress.yml 
```


### Validate Ingress Routing & Regex Path Rewriting

```bash
# Check Ingress resource status
kubectl get ingress -A

# Test HTTP connection to localhost
curl -i http://localhost/

# Test specific application endpoints via curl
curl -i http://localhost/auth/login/
```

Open your browser and navigate to:

http://localhost/