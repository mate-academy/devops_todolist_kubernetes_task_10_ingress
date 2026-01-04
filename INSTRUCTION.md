# ===============================
# INSTRUCTION.md — Validation Steps
# ===============================


kubectl get pods -n todoapp
kubectl get pods -n mateapp
kubectl get pods -n mysql


kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- env | grep DB_


kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- df -h | grep /app/data


kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- ls /app/configs
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/configs/PYTHONUNBUFFERED


kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- ls /app/secrets
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/secrets/NAME
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/secrets/USER
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/secrets/PASSWORD
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/secrets/HOST


kubectl logs -n mateapp -l app=todoapp --tail=20
kubectl logs -n mateapp -l app=my-cronjob-app --tail=20


kubectl get pods -n mysql
kubectl exec -n mysql -it mysql-0 -- sh -c 'ls /docker-entrypoint-initdb.d'
kubectl exec -n mysql -it mysql-0 -- sh -c 'mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;"'


kubectl get ingress -n todoapp
