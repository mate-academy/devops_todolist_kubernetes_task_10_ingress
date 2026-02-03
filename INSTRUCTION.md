# Validating ingress routing
# Bring up app
Run bootstrap.sh
# Add ingress rule
Run "kubectl apply -f .infrastructure/ingress/ingress.yml"
## Verification Steps
1. Go to the Todoapp http://localhost/
2. Add "test" todo into todoapp
3. Path "/todolist/new/" is added an no 404 in the devtools network tab