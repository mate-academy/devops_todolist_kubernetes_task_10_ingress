# Validation checklist

## 1) Кластер і контролер інгреса
kubectl get nodes
kubectl -n ingress-nginx get pods
# усі поди контролера мають бути Ready

## 2) Ресурси апки
kubectl -n todo get deploy,svc
# service todo-svc має порт 80 (targetPort = порт контейнера)

## 3) Ingress створений і привʼязаний
kubectl -n todo get ingress todo-web -o wide
kubectl -n todo get ingress todo-web -o yaml | grep -E "host:|path:|use-regex|rewrite-target"

## 4) Доступ з хоста
curl -I http://localhost
curl -sSf http://localhost/ | head -n 5

## 5) Відсутність 404
# у браузері відкрий http://localhost і в DevTools → Network переконайся, що немає 404
# додатково:
for p in / /static/ /api/health; do curl -s -o /dev/null -w "%{http_code} $p\n" http://localhost$p; done
# коди мають бути 200/30x (але не 404)

## 6) Діагностика у разі проблем
kubectl -n todo describe ingress todo-web
kubectl -n ingress-nginx logs deploy/ingress-nginx-controller --tail=200
kubectl -n todo get endpoints todo-svc -o yaml   # переконайся, що бекенд-ендоінти є
