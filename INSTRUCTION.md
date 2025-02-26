1. Apply the Ingress:
- kubectl apply -f .infrastructure/ingress/ingress.yml

2. Check Ingress status:
- kubectl get ingress -n todoapp

3. Check if the app is accessible:
- Open http://localhost in your browser
