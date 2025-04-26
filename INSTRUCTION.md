# Instructions for Deploying Application and Validating Ingress Nginx
## Deploying Resources Using bootstrap.sh
The bootstrap.sh script contains all commands to deploy
`./bootstrap.sh`
## Validating Ingress-Nginx
To check that Ingress was created run such commands

```
kubectl get ns | grep ingress-nginx
kubectl get ingress -n todoapp
```