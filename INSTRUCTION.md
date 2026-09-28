# How to validate the changes

1. Create the kind cluster from the config file
```
kind create cluster --config cluster.yml
```

2. Deploy the app, install the ingress controller and apply the ingress rules
```
./bootstrap.sh
```

3. Wait until the ingress controller pod is `Running`
```
kubectl get pods -n ingress-nginx
```

4. Check that the Ingress exists and uses the `nginx` class
```
kubectl get ingress -n todoapp
```

5. Check that the root path returns status 200
```
curl -I http://localhost/
```

6. Check that a nested path is forwarded to the app and returns status 200
```
curl -I http://localhost/api/
```

7. Open the app in the browser
```
http://localhost
```

8. Open the browser DevTools (F12), go to the Console and Network tabs, and reload the page. There must be no requests failing with the 404 status code.
