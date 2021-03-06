# vitaliygut_microservices
vitaliygut microservices repository

HW21
=========================================
kubernetes-3

1. Установлен Ingress Controller
2. Перенастроил Ingress на прием только HTTPS трафика
3. Настроил Network Policy
4. Создал ресурс дискового хранилища в YC, добавили подключил к кластеру в виде PersistentVolume и подключили к деплою mongo


HW20
=========================================
kubernetes-2

1. Установил локально minikube
2. Обновлены манифесты для Reddit, приложение запущено в локальном minikube
3. Создал новый кластер настройка в yandex cloud
```
kubectl get nodes                                 
NAME                        STATUS   ROLES    AGE   VERSION
cl1vc8veqll1tum7dhs8-ovoj   Ready    <none>   15m   v1.19.7
cl1vc8veqll1tum7dhs8-ylen   Ready    <none>   15m   v1.19.7
```
4. Приложение запущено в кластере yandex cloud
```
kubectl get pods -n dev       
NAME                       READY   STATUS    RESTARTS   AGE
comment-85c44d9b6b-gfdrm   1/1     Running   0          14m
comment-85c44d9b6b-mpgnt   1/1     Running   0          14m
comment-85c44d9b6b-w8nlr   1/1     Running   0          14m
mongo-6b9fcfd49f-pqt62     1/1     Running   0          14m
post-65984c87c6-7fpc5      1/1     Running   0          14m
post-65984c87c6-q85ph      1/1     Running   0          14m
post-65984c87c6-z27nf      1/1     Running   0          14m
ui-7f966cccd8-dzx52        1/1     Running   0          14m
ui-7f966cccd8-fvg9l        1/1     Running   0          14m
ui-7f966cccd8-g5hrd        1/1     Running   0          14m
```
![yandex cloud](https://user-images.githubusercontent.com/27003519/116011348-32be3f00-a62d-11eb-99df-9ea8fd8b7503.png)
http://84.201.130.109:30482/



HW19
=========================================
kubernetes-1

1. Развернуты виртуалки
2. Создан кластер 
```
kubectl get nodes -o wide
NAME         STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
kubemaster   Ready    control-plane,master   42m   v1.21.0   10.130.0.32   <none>        Ubuntu 18.04.5 LTS   4.15.0-55-generic   docker://20.10.6
kubernode1   Ready    <none>                 31m   v1.21.0   10.130.0.28   <none>        Ubuntu 18.04.5 LTS   4.15.0-55-generic   docker://20.10.6
kubernode2   Ready    <none>                 31m   v1.21.0   10.130.0.8    <none>        Ubuntu 18.04.5 LTS   4.15.0-55-generic   docker://20.10.6
```
3. Созданы тестовые манифесты post,ui,comment,mongo-deployment.yml
5. Запущены поды 
```
kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
command-demo                         0/1     Completed   0          21m
comment-deployment-7bdd8d59f-lsm6r   1/1     Running     0          46s
mongo-deployment-545fd54f7c-2svm5    1/1     Running     0          34s
post-deployment-678767745-x87fl      1/1     Running     0          25s
ui-deployment-7b597bbd6f-c8l45       1/1     Running     0          3m50s
```

HW18
=========================================
logging-1

Основное задание
1. Обновил код микросервиса
2. Сделал отдельный docker-compose-logging.yml
3. Создал конфигурацию fluend и собрал образ
4. Подключил сервис Zipkin для просмотра трейсов
5. Обновил собранные образы DockerHub

HW17
=========================================
monitoring-2

Основное задание
1. Добавил cAdvisor для мониторинга docker
2. Добавил Grafana для визуалного отображения собранных метрик из prometheus
3. Добавил Alertmanager для оправки нотификаций
4. Обновил Makefile 
5. Обновил собранные образы DockerHub

HW16
=========================================
monitoring-1

1. Запущен docker  с prometheus;

2. Собран образ prometheus с необходимыми конфигом;

3. docker-compose.yml добавлен сервис prometheus;

Задания со ⭐
1. docker-compose.yml добавленnode_exporter для сбора метрик;

2. docker-compose.yml  добавлен mongodb_exporter для сбора метрик с MongoDB; 

3. docker-compose.yml blackbox_exporter для проверки работы сервисов ui, post и comment;

4. Создан Makefile - билд образа по отдельносьти и все разом , пуш подготовленных имаджей на docker hub, запускает docker-compose.yml, очистка docker-machine

HW15
=========================================
gitlab-ci-1

1. Развернут gitlab из контейнера
2. Создан тестовый pipeline
3. Добавлен docker-compouse для запуска gitlab-ci и gitlab-runner.

HW14
=========================================
Docker-4

Параметризуем переменные окружения с помощью файла .env
USERNAME=user
PORT=80
VERS=1.0
COMPOSE_PROJECT_NAME=reddit
Базовое имя проекта можно задать двумя спосабами:
  1.   -p, --project-name NAME     Specify an alternate project name
                              (default: directory name)
  2. добавить переменную в файл .env COMPOSE_PROJECT_NAME=reddit

Задания со ⭐
Создаем файл docker-compose.override.yml
Для запуска puma с нужными параметрами используем изменение директивы CMD
  ui:
    command: puma --debug -w 2
  comment:
    command: puma --debug -w 2
  post:
    command: puma --debug -w 2

Для запуска файла следующих команд: docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d

HW13
=========================================

Выполненные работы
Разбиваем наше приложение на несколько компонентов
Запускаем наше приложение
Оптимизируем наше приложение
Используем volume

HW12
=========================================
Задания со ⭐
1. Создаем директорию packer и файл docker.json
```
{
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "{{user `key_file`}}",
            "folder_id": "{{user `folder_id`}}",
            "source_image_family": "{{user `source_image_family`}}",
            "image_name": "reddit-docker-base-{{timestamp}}",
            "subnet_id": "{{user `subnet_id`}}",
            "use_ipv4_nat": true,
            "image_family": "reddit-docker-base",
            "ssh_username": "ubuntu",
            "platform_id": "standard-v1"
        }
    ],
    "provisioners": [
        {
        "type": "ansible",
        "playbook_file": "../ansible/playbooks/install_docker.yml"
        }
        ]
}
```
2. Создаем директорию terraform и файл main.tf outputs.tf inventory.tmpl
Для динамического файла inventory.ini в файл outputs.tf добавляем 
```
## The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  host-name-docker = yandex_compute_instance.docker.*.name,
  docker-ext-ip = yandex_compute_instance.docker.*.network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory.ini"
}
```
шаблон inventory.tmpl 
```
[docker]
%{ for index, host-name in host-name-docker ~}
${host-name} ansible_host=${docker-ext-ip[index]}
%{ endfor ~}
```
3. Создаем директорию ansible и необходимые файлы ansible.cfg и playbook
