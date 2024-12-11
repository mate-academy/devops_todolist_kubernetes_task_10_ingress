# How to validate the changes

#Use this command to run Bootstrap Script

```
./bootstrap.sh
```

Use this commands to verify Deployment

```
kubectl get all -n todoapp
kubectl get all -n mysql
```

Check Ingress resource:

```
kubectl get ingress -n todoapp
```

### How to validate the changes:
1. Access the application via http://localhost.
2. Check for successful page load without any 404 errors.