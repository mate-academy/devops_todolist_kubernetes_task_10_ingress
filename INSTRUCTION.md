# Перевірка Ingress (ELI5)

Цей файл пояснює реалізацію Ingress, показує, як перевірити завдання, і допомагає
знайти причину помилки.

## Як рухається запит

```text
браузер
  -> localhost:80
  -> port mapping control-plane:80
  -> ingress-nginx controller
  -> Ingress rule
  -> Service todoapp-service:80
  -> Django Pod:8080
```

Якщо ламається перший або другий перехід, браузер показує
`ERR_CONNECTION_RESET` чи `Connection refused`. Якщо Ingress не знаходить
Service, зазвичай буде `503`. Якщо правило шляху неправильне, сторінка може
відкритися, але CSS, JavaScript або API-запити отримуватимуть `404`.

## Що реалізовано і чому

### 1. Ingress і Service мають бути в одному namespace

Ingress не може посилатися на звичайний Service з іншого namespace. Service
`todoapp-service` знаходиться в `todoapp`, тому в metadata Ingress потрібен:

```yaml
namespace: todoapp
```

### 2. Використати справжнє ім'я Service

У `.infrastructure/app/clusterIp.yml` Service називається
`todoapp-service`. Саме це ім'я має бути в `backend.service.name`.

### 3. Додати IngressClass

Явно вкажи контролер, який повинен обробляти правило:

```yaml
spec:
  ingressClassName: nginx
```

### 4. Захопити й зберегти шлях

Вимога завдання просить regex capture. Якщо завжди переписувати шлях на `/`,
запити `/static/...`, `/api/...` та `/auth/...` також стануть `/`. Через це
ресурси сторінки або API працюватимуть неправильно.

Робоча конфігурація `.infrastructure/ingress/ingress.yml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: todo-ingress
  namespace: todoapp
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  ingressClassName: nginx
  rules:
    - http:
        paths:
          - path: /(.*)
            pathType: ImplementationSpecific
            backend:
              service:
                name: todoapp-service
                port:
                  number: 80
```

Приклади:

- `/` захоплює порожній рядок і передається як `/`;
- `/api/health` захоплює `api/health` і передається як `/api/health`;
- `/static/css/custom.css` не перетворюється на `/`.

### 5. Контролер має працювати на control-plane

У `cluster.yml` порт хоста `80` проброшено саме в контейнер control-plane.
Ingress controller використовує `hostPort: 80`, тому його Pod також повинен
бути на control-plane, який має label `ingress-ready=true`.

Після встановлення ingress-nginx перевір:

```bash
kubectl get pods -n ingress-nginx -o wide
```

У колонці `NODE` для controller очікується `todo-cluster-control-plane`.
Для цього `bootstrap.sh` після встановлення контролера додає прив'язку до
правильного вузла:

```bash
kubectl patch deployment ingress-nginx-controller \
  --namespace ingress-nginx \
  --type=merge \
  --patch '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true"}}}}}'
```

Після patch дочекайся готовності:

```bash
kubectl rollout status deployment/ingress-nginx-controller \
  --namespace ingress-nginx \
  --timeout=180s
```

### 6. `bootstrap.sh` повинен застосовувати Ingress

`bootstrap.sh` застосовує `.infrastructure/ingress/ingress.yml` після готовності
контролера:

```bash
kubectl apply -f .infrastructure/ingress/ingress.yml
```

## Чистий запуск

Запускай із кореня репозиторію. Видалення кластера стирає всі навчальні дані,
тому виконуй першу команду лише коли старі дані більше не потрібні.

```bash
kind delete cluster --name todo-cluster
kind create cluster --name todo-cluster --config cluster.yml
./bootstrap.sh
```

Якщо кластер не видаляєш, прибери старий помилковий Ingress із namespace
`default`, інакше він залишиться окремим ресурсом:

```bash
kubectl delete ingress todo-ingress --namespace default
```

## Покрокова перевірка

### 1. Усі Pods готові

```bash
kubectl get pods -A -o wide
```

Очікується:

- MySQL Pods — `Running` і `1/1`;
- Django Pods — `Running` і `1/1`;
- `ingress-nginx-controller` — `Running`, `1/1`, на control-plane.

### 2. Застосунок працює без Ingress

```bash
curl -i http://localhost:30007/
```

Очікується `HTTP/1.1 200 OK`. Якщо цей тест падає, спочатку виправляй
Deployment або Service — Ingress тут ще ні до чого.

### 3. Ingress знаходиться у правильному namespace

```bash
kubectl get ingress -A
kubectl describe ingress todo-ingress --namespace todoapp
```

У `describe` очікується backend приблизно такого вигляду:

```text
todoapp-service:80 (<Pod-IP>:8080,...)
```

Повідомлення `service not found` або `<error>` означає неправильний namespace
чи ім'я Service.

### 4. Service має живі endpoints

```bash
kubectl get service todoapp-service --namespace todoapp
kubectl get endpoints todoapp-service --namespace todoapp
```

Endpoints не повинні бути порожніми: там мають бути адреси Django Pods із
портом `8080`.

### 5. Перевірка через Ingress

```bash
curl -i http://localhost/
curl -i http://localhost/api/health
curl -i http://localhost/api/ready
```

Усі три запити мають повертати `200`.

### 6. Перевірка браузером

Відкрий <http://localhost>, потім DevTools -> Network і перезавантаж сторінку.
Відфільтруй запити за статусом `404`. Список має бути порожнім. Окремо перевір:

- CSS і JavaScript завантажуються як CSS/JS, а не як HTML;
- сторінки `/auth/login/` та `/api/` відкриваються;
- у Console немає помилок завантаження ресурсів.

## Діагностика

```bash
kubectl get ingressclass
kubectl get ingress -A
kubectl describe ingress todo-ingress --namespace todoapp
kubectl get pods -n ingress-nginx -o wide
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller --tail=100
kubectl get service,endpoints --namespace todoapp
docker port todo-cluster-control-plane
curl -v --max-time 5 http://localhost/
```

Підказки:

- `ERR_CONNECTION_RESET` — controller не слухає порт на control-plane;
- `404` від nginx — правило Ingress не збіглося зі шляхом;
- `503 Service Temporarily Unavailable` — Service або endpoints не знайдені;
- `service ... not found` у `describe`/logs — неправильні namespace або ім'я;
- NodePort повертає `200`, а Ingress ні — Django справний, шукай проблему між
  host port, ingress controller, Ingress rule та ClusterIP Service.
