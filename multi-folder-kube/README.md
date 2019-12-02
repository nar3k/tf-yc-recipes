Данный пример
1) создает сеть в фолдере network, подсети в фолдерах для staging и production кластеров ( папка /infra)
2) создает сервисные аккаунты в фолдерах для staging и production и дает им соотвествующие права ( папки /k8s-production /k8s-staging , файл sa.tf )
3) создает кластеры в фолдераз для staging и production ( папки /k8s-production /k8s-staging , файл k8s.tf )


1) Создаете бакет для стейта
2) Создаете SA с правами editor в том же фолдере, что и бакет Создаете к нему статический ключ и загрузите переменные
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
3) Создаете фолдеры для public, stage, prod.
4) Заходите в фолдер infra
4) Смотрите в infra/terraform.tfvars - заполняете там переменные
5) В infra/main.tf, заполняете путь до файла стейта
6) terraform init
7) terraform apply - сделает сети и  подсети
8) Далее надо пройти в фолдеры staging и prod, руками включить на подсетях интернет
9) Далее заходите в фолдеры k8s-production,k8s-staging - там правите terraform.tfvars и main.tf
10) terraform init
11) terraform apply создаст кластеры

Как улучшить пример

1) Сделать модули деплоя кластеров
2) Сделать мультизональный пример
