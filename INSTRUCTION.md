## 📄 INSTRUCTION.md

### Kubernetes ToDo App + Ingress Setup

#### 📦 1. Створити кластер Kind

```bash
kind create cluster --config cluster.yml
```

#### ⚙️ 2. Застосувати всі ресурси

Виконати скрипт:

```bash
./bootstrap.sh
```

> Якщо `bootstrap.sh` не запускається — дати права:

```bash
chmod +x bootstrap.sh
```

#### 📅 3. Встановити Ingress Controller

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

#### 🔍 4. Перевірити, що `ingress-nginx-controller` запущено

```bash
kubectl get pods -n ingress-nginx
```

Очікуємо `Running` для:

```
ingress-nginx-controller-xxxxxxx
```

#### 🌐 5. Перевірити доступність застосунку через Ingress

```bash
curl http://localhost/api/ready
curl http://localhost/api/health
curl http://localhost/api/todos/
```

Очікуваний результат:

* `/api/ready` → `200 OK`
* `/api/todos/` → `[]` (або список задач, якщо є)

#### 📌 6. Використані сервіси:

* `todoapp-service` (ClusterIP) — використовується в Ingress
* `todoapp-nodeport` — для дебагу

#### 📂 Структура маніфестів:

```
.infrastructure/
├── app/
│   ├── configMap.yml
│   ├── deployment.yml
│   ├── hpa.yml
│   ├── nodeport.yml
│   ├── ns.yml
│   ├── pv.yml
│   ├── pvc.yml
│   ├── secret.yml
│   └── clusterIp.yml
├── ingress/
│   └── ingress.yml
├── mysql/
│   ├── configMap.yml
│   ├── ns.yml
│   ├── secret.yml
│   ├── service.yml
│   └── statefulSet.yml
```

#### 💡 Примітка

Ingress використовує хост `localhost`, тому доступ можливий лише з локального середовища.
