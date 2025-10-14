# Описание проекта
Данный проект представляет собой демонстрацию цикла CI/CD, включающего:
- сборку и тестирование приложения;
- упаковку в Docker-образ;
- публикацию артефакта в GitHub Container Registry (GHCR);
- автоматическое развертывание приложения в Kubernetes через Helm-чарт.

### Приложение
В качестве тестового приложения используется простое Go API, которое:
- отвечает на запрос GET / строкой:Hello from myapp-api!
Исходный код приложения находится в каталоге: itog_project/services/api/

### Workflow CI (.github/workflows/ci.yml)
Выполняет:
1. Сборку и тестирование приложения на Go;
2. Кэширование зависимостей для ускорения последующих сборок;
3. Сборку Docker-образа через docker/build-push-action;

# Требования для запуска:
## docker: сборка и запуск контейнеров;
## Minikube/K&S: кубернетис-кластер;
## Terraform: IaC-конфигурации;
## Go: сборка и тестирование приложения;
## GitHub Actions: CI/CD pipeline


#Пользование:
## Клонирование репозитория:
### git clone https://github.com/Rustamchic/codeby-devops.git cd codeby-devops

## Сборка docker-образа:
### docker build -t myapp-api:latest -f itog_project/services/api/Dockerfile .
## Локальный запуск:
### docker run -d -p 8080:8080 --name myapp myapp-api curl http://localhost 8080/
## Разворачивание в K&S:
###minikube start helm upgrade --install api ./itog_project/charts/api --namespace myapp --create-namespace


