## Step 1. Run bootstrap.sh file

This file contains all the commands we need to deploy our app on nginx server

## Step 2. Verify Ingress Controller Placement

We need to ensure the Ingress controller pod is running on the `kind-control-plane` node,
as this is the only node with ports forwarded to your host.


Run the following command:
```bash
kubectl get pods -n ingress-nginx -o wide
```
Success criteria:

Pod Status: Running

Ready: 1/1

NODE column: Must strictly be kind-control-plane

## Step 3. Check MySQL Database Availability
Before testing the application, ensure the database is fully initialized and ready to accept connections.

Check the pod status:

```bash
kubectl get pods -n mysql
```
Expected: Running and 1/1 Ready

Check the container logs:

```bash
kubectl logs mysql-0 -n mysql --tail=50
```
Look for the line: [Server] /usr/sbin/mysqld: ready for connections.

## Step 4. Verify Ingress Routing Status
Ensure that the routing rules have been successfully picked up by the Ingress controller.

Run the following command:

```bash
kubectl get ingress -n todoapp
```
Success Criteria:
The ADDRESS column should display localhost or 127.0.0.1. This means the Ingress controller has successfully mapped the route.

## Step 5. Final Web Interface Check

Navigate to: http://localhost or http://127.0.0.1

Verify that the todoapp interface loads correctly and successfully fetches data from the MySQL database.

