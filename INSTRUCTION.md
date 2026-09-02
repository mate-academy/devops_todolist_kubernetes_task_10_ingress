# Django ToDo List — Ingress

## 1. Create the kind cluster

```
kind create cluster --config cluster.yml
```

Verify the cluster:

```
kubectl get nodes
```

## 2. Deploy the application

Run:

```
chmod +x bootstrap.sh
./bootstrap.sh
```

The script deploys the ToDo application, installs the NGINX Ingress Controller and applies the Ingress manifest.

## 3. Verify the application

Check the application Pods:

```
kubectl get pods -n todoapp
```

All application Pods must be in the `Running` state.

Check the Ingress:

```
kubectl get ingress -n todoapp
```

Check the NGINX Ingress Controller:

```
kubectl get pods -n ingress-nginx
```

The Ingress Controller Pod must be `Running`.

## 4. Test HTTP access

Open:

```
http://localhost
```

The Django ToDo application must be displayed.

## 5. Verify Ingress routing

The Ingress must contain one HTTP rule with one path-based rule:

```
/(.*)
```

The rule must route requests to the ToDo application Service.

## 6. Verify browser requests

Open browser Developer Tools and check the Console and Network tabs.

There must be no failed requests with HTTP status `404`.

## 7. Final verification

The task is complete when:

* the kind cluster is running;
* the ToDo application is deployed;
* the NGINX Ingress Controller is running;
* the Ingress resource exists;
* the Ingress contains one HTTP rule;
* the Ingress contains one regex path rule;
* the `/` path is routed to the ToDo application;
* `http://localhost` opens the application;
* there are no `404` requests in the browser console.
