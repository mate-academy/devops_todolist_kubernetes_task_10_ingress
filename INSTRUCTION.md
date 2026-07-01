# Validation

After running `bootstrap.sh`, use the steps below to confirm everything is working.

## 1. Run bootstrap

```bash
./bootstrap.sh
```

Confirm every resource shows `created` or `configured`, with no `error` lines. The script will automatically wait for ingress-nginx and mysql pods to be ready before continuing.

## 2. Ingress-nginx validation

Confirm the controller is running:

```bash
kubectl get pods -n ingress-nginx
```

Expected: `1/1 Running`.

## 3. MySQL validation

Check all StatefulSet pods are running:

```bash
kubectl get pods -n mysql
```

Expected: `mysql-0`, `mysql-1`, `mysql-2` all `1/1 Running`.

Check the PVCs created by `volumeClaimTemplates` are bound:

```bash
kubectl get pvc -n mysql
```

Expected: all three PVCs show `Bound`.

Confirm MySQL started successfully and `init.sql` ran:

```bash
kubectl logs mysql-0 -n mysql
```

Look for `ready for connections` near the end, and confirm `Creating database app_db` and user creation messages appear without errors.

Exec into the pod and verify the database and tables exist:

```bash
kubectl exec -n mysql -it mysql-0 -- mysql -uapp_user -p app_db -e "SHOW TABLES;"
```

## 4. App validation

Check the pod is running:

```bash
kubectl get pods -n todoapp
```

Expected: `1/1 Running`.

Check the PVC is bound:

```bash
kubectl get pvc -n todoapp
```

Expected: `pvc-data` shows `Bound`.

Confirm the app connected to MySQL successfully (no connection errors on startup):

```bash
kubectl logs -l app=todoapp -n todoapp
```

## 5. Ingress validation

Check the Ingress has an address assigned:

```bash
kubectl get ingress -n todoapp
```

Expected: `ADDRESS` column shows `localhost`.

Describe the Ingress to confirm routing is correct:

```bash
kubectl describe ingress todoapp-ingress -n todoapp
```

Confirm:
- `Ingress Class: nginx`
- Annotations include `use-regex: true` and `rewrite-target: /$1`
- Backend resolves to `todoapp-service:80` with an active pod IP

## 6. End-to-end test via Ingress

Test the app is reachable through the Ingress:

```bash
curl http://localhost/api/health
```

Expected: `200` response confirming the app is up and reachable externally.

Optionally, open `http://localhost/` in a browser to confirm the UI loads and the app can read/write data through MySQL end-to-end.