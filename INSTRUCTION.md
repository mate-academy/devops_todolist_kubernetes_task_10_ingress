# 1) How to validate the changes:

    kubectl apply -f ./.infrastructure/ingress/ingress.yml 

**Check creating ingress:**

    kubectl get ingress -n todoapp

**Open your browser and go at url: *http:/localhost***