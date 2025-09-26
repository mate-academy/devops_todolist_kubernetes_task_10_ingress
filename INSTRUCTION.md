## Before validation, apply all infrastructure manifests:
```shell
    ./bootstrap.sh
```

## Validate that all pods are running:
```shell
    kubectl get pods -n todoapp
    kubectl get pods -n ingress-nginx
```

## Validate that ingress was created:
```shell
    kubectl get ingress -n todoapp
```

Open [localhost](http://localhost:80) and verify that app is running and you don't see the error page 
