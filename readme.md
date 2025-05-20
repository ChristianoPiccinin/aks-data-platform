# Como subir o ambiente via terraform

```console
az login
terraform init
terraform plan
terraform apply
```

# Conecte-se ao AKS:
```console
az account set --subscription 
az aks get-credentials --resource-group rg-aks-dev --name aksdata-aks
```

# Verifique a conexão:
```console
kubectl get nodes
```

## 📥 1. Instalar o Helm (caso ainda não tenha)
```console
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## 📁 2. Criar namespace e instalar o ArgoCD
```console
kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd \
  --namespace argocd \
  --version 5.8.5 \
  --set server.service.type=LoadBalancer
```

## 🌐 3. Obter a URL de acesso ao ArgoCD
```console
kubectl get svc argocd-server -n argocd
```

#🔐 4. Obter senha inicial do admin
```console
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d && echo

```
Usuário: admin



## 🔗 5. Conectar o ArgoCD ao seu GitHub


##


# ✅ ETAPA 4 – Instalação e configuração do NGINX Ingress Controller
## 🛠️ 1. Instalar o NGINX Ingress Controller

```console
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

kubectl create namespace ingress-nginx


helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=LoadBalancer

```

## 2. Obter o IP externo (public IP)
```console
kubectl get svc ingress-nginx-controller -n ingress-nginx

```

## 3. Usar domínio com nip.io para facilitar
A mágica do nip.io é que ele converte um IP em domínio automaticamente.
```console
minio.20.226.123.45.nip.io
airflow.20.226.123.45.nip.io
grafana.20.226.123.45.nip.io

```

## 📄 4. Criar Ingress para expor o MinIO
A mágica do nip.io é que ele converte um IP em domínio automaticamente.
```console
minio.20.226.123.45.nip.io
airflow.20.226.123.45.nip.io
grafana.20.226.123.45.nip.io

```


🧱 Etapa 1 – Criar os Namespaces

```console
kubectl create namespace kafka
kubectl create namespace deepstorage
kubectl create namespace orchestrator
kubectl create namespace processing
kubectl create namespace monitoring
kubectl create namespace viz


```



🌍 Etapa 4 – Testar os acessos pelas URLs com .nip.io
Acesse os serviços pelo navegador, exemplo:
```console
MinIO: http://minio.74-179-203-115.nip.io

Airflow: http://airflow-web.74-179-203-115.nip.io

Kafka UI: http://kafka-ui.74-179-203-115.nip.io

Grafana: http://grafana.74-179-203-115.nip.io

Usuários padrão estão nos values.yaml, por exemplo:

MinIO: admin / admin123456

Airflow: admin / admin123

Grafana: admin / admin123

```