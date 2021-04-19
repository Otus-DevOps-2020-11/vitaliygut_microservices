# vitaliygut_microservices
vitaliygut microservices repository
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