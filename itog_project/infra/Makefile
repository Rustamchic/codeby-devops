bootstrap:
 kubectl apply -f itog_project/infra/k8s/bootstrap/argocd/namespace.yaml
 # Установка ArgoCD через Helm:
 helm repo add argo https://argoproj.github.io/argo-helm
 helm repo update
 helm upgrade --install argocd argo/argo-cd -n argocd --wait
 kubectl apply -f itog_project/infra/k8s/bootstrap/argocd/project.yaml
 kubectl apply -f itog_project/infra/k8s/bootstrap/argocd/app-myapp.yaml
