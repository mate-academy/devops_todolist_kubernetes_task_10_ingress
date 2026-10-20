# How to validate the Ingress

1. Create the cluster:
```
   kind create cluster --config cluster.yml
```

2. Deploy the app and the ingress controller:
```
   bash bootstrap.sh
```

3. Pin the ingress controller to the control-plane node (only this node has port 80 mapped to the host):
```
   kubectl patch deployment ingress-nginx-controller -n ingress-nginx -p '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true","kubernetes.io/os":"linux"}}}}}'
   kubectl rollout status deployment ingress-nginx-controller -n ingress-nginx
```

4. Apply the Ingress:
```
   kubectl apply -f .infrastructure/ingress/ingress.yml
   kubectl get ingress -n todoapp
```

5. Open http://localhost in the browser. The app should load, and the browser console (F12) should show no 404 errors.