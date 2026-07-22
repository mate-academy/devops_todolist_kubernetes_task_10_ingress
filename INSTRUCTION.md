# Instructions

## 1. Create the cluster and deploy the app

Create the kind cluster from the configuration file:

```bash
kind create cluster --config cluster.yml
```

Then deploy the application, the database and the ingress controller:

```bash
./bootstrap.sh
```

> Note: run the script from the directory where it is located, or specify the full path to it. If the script doesn't run, it may be missing execute permissions:
> ```bash
> chmod +x bootstrap.sh
> ```

The script creates three namespaces (`mysql`, `todoapp`, `ingress-nginx`), deploys all resources and applies the Ingress rule.

## 2. Verify the pods are running

Database:

```bash
kubectl get pods -n mysql
```

Expected output:

NAME READY STATUS RESTARTS AGE
mysql-0 1/1 Running 0 21m
mysql-1 1/1 Running 0 19m
mysql-2 1/1 Running 0 17m


During the first minutes you may see the last pod not ready yet:

NAME READY STATUS RESTARTS AGE
mysql-0 1/1 Running 0 21m
mysql-1 1/1 Running 0 19m
mysql-2 0/1 Running 0 17m


This is expected — a StatefulSet starts its pods sequentially: `mysql-1` won't start until `mysql-0` is Ready, and `mysql-2` waits for `mysql-1`. On top of that, each pod has liveness and readiness probes, so it takes a while before a pod reports as ready.

Application:

```bash
kubectl get pods -n todoapp
```

Expected output:

NAME READY STATUS RESTARTS AGE
todoapp-5c95957f88-cgpqb 1/1 Running 0 18m
todoapp-5c95957f88-wm8h5 1/1 Running 0 18m


## 3. Verify the Ingress

Open http://localhost/ in a browser (port 80 by default). The application's main page should load with all styles applied.

To confirm the Ingress routes requests correctly, open the developer tools (F12), switch to the **Network** tab and reload the page (F5). All requests to the application should return `200`.

> Note: you may see a `307` redirect for an external resource (the Google Fonts stylesheet is upgraded from HTTP to HTTPS by the browser itself). That's not an error — what matters is that there are no `404` responses.