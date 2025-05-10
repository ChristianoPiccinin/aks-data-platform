🚀 Fase 2 – Deploy do ArgoCD e Setup GitOps
📌 Objetivos
Instalar o ArgoCD no AKS (dev e prod)

Criar a estrutura de repositório Git com pastas por ambiente e serviço

Conectar o ArgoCD ao repositório Git

Fazer o primeiro Application apontando para os manifests de infraestrutura base

📁 Estrutura sugerida do repositório GitOps
bash
Copy
Edit
gitops/
├── apps/
│   ├── dev/
│   │   ├── argocd/
│   │   ├── kafka/
│   │   ├── spark/
│   │   ├── pinot/
│   │   ├── minio/
│   │   ├── nats/
│   │   └── monitoring/  # prometheus + grafana
│   └── prod/
│       ├── ...
├── base/
│   ├── argocd/
│   ├── kafka/
│   ├── spark/
│   ├── ...
└── README.md

✅ Passo 1: Instalar ArgoCD no AKS
Vamos usar o Helm para facilitar o deploy. Você deve executar o seguinte no terminal conectado ao AKS:

bash
Copy
Edit
# Namespace e repo
kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd -n argocd \
  --set server.service.type=LoadBalancer \
  --set configs.cm."kustomize.buildOptions"="--enable-helm"

  
Aguarde alguns minutos e obtenha o IP externo do ArgoCD:


obter a senha:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

bash
Copy
Edit
kubectl get svc -n argocd
✅ Passo 2: Acessar o ArgoCD UI
Acesse pelo navegador via IP do LoadBalancer, porta 80.
Para obter a senha inicial do admin:

bash
Copy
Edit
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
✅ Passo 3: Conectar com seu repositório Git
Na UI do ArgoCD:

Settings → Repositories → Connect Repo using HTTPS ou SSH

Use o seu repositório Git com estrutura acima

✅ Passo 4: Criar um Application
Exemplo: Aplicar o Strimzi do ambiente dev


criar os demais namespaces 
kubectl create ns kafka
kubectl create ns spark
kubectl create ns pinot
kubectl create ns minio
kubectl create ns nats
kubectl create ns monitoring
