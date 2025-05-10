Fase 1: Terraform da Infraestrutura
Você confirma que deseja manter os ambientes separados em dois resource groups (rg-dev, rg-prod) como discutido antes?
Se sim, posso gerar agora os scripts Terraform para provisionar:

AKS (com 2 node pools)

ADLS

ACR

Identidades e permissões

Confirma seguir assim? Deseja os nomes dos recursos em português ou inglês (ex: dados-prod, data-prod)?






You said:
confirmo, quero ter 2 ambientes 


ChatGPT said:
Ótimo! Vamos seguir com a Fase 1 – Provisionamento da Infraestrutura com Terraform, criando 2 ambientes separados:

🌐 Estrutura dos Ambientes
Ambiente	Resource Group	AKS Cluster	ADLS	Container Registry
dev	rg-dados-dev	aks-dados-dev	adlsdadosdev	acrdadosdev
prod	rg-dados-prod	aks-dados-prod	adlsdadosprod	acrdadosprod

📁 Estrutura de Diretórios
bash
Copy
Edit
infra/
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── prod/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
✨ Recursos Provisionados por Ambiente
AKS com:

2 node pools (geral + spot para batch/stream)

RBAC habilitado

ADLS Gen2 com hierarquia de namespace

Azure Container Registry (ACR)

Identidade gerenciada para montar o ADLS via CSI Driver

