Зробити fork репозиторію та клонувати його локально.

Запустити кластер за допомогою kind:
kind create cluster --config cluster.yml

Запустити скрипт деплою:
./bootstrap.sh

Перевірити, що pod застосунку запущений:
kubectl get pods -n todoapp

Перевірити, що Ingress Controller працює:
kubectl get pods -n ingress-nginx

Перевірити створення Service та Ingress:
kubectl get svc -n todoapp
kubectl get ingress -n todoapp

Відкрити в браузері:
http://localhost

Переконатися, що застосунок відкривається та в консолі браузера немає 404 помилок.
