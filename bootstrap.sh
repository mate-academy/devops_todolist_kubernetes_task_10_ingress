# ... твій існуючий деплой app і service у namespace todo

# застосувати ingress
kubectl apply -f ./infrastructure/ingress/ingress.yml

# (не обов'язково, але корисно) почекати, поки контролер підхопить Ingress
kubectl -n todo get ingress todo-web
