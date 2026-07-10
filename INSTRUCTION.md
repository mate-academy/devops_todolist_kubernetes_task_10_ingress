# INSTRUCTION.md

## Validation

```bash
kind create cluster --config cluster.yml
./bootstrap.sh
kubectl apply -f ./infrastructure/ingress/ingress.yml
```

Open:

```
http://localhost
```

Expected result:

* The ToDo application is available.
* No HTTP 404 errors are present in the browser console.
