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

# Instalar o ArgoCD
helm install argocd argo/argo-cd -n argocd \
  --set server.service.type=LoadBalancer
Aguarde alguns minutos e obtenha o IP externo do ArgoCD:

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

yaml
Copy
Edit
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kafka-dev
  namespace: argocd
spec:
  destination:
    namespace: kafka
    server: https://kubernetes.default.svc
  project: default
  source:
    repoURL: https://github.com/ChristianoPiccinin/aks-data-platform
    targetRevision: HEAD
    path: apps/dev/kafka
  syncPolicy:
    automated:
      prune: false
      selfHeal: true
