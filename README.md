## Guideline

1. Create cluster with `kind create cluster --config cluster.yml`
1. Run the `bootstrap.sh` script to deploy all resources:

## Instructions on how to validate

1. Check todoapp pods

   kubectl get pods -n todoapp

2. Check mysql pods

   kubectl get pods -n mysql

3. Check ingress

   kubectl get ingress -n todoapp

4. CHeck app

   http://localhost/
