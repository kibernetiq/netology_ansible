# Домашнее задание к занятию 6 «Создание собственных модулей»

## Основная часть

**Шаг 1.** В виртуальном окружении создайте новый `my_own_module.py` файл.

**Шаг 2.** Наполните его содержимым или возьмите это наполнение [из статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).

**Шаг 3.** Заполните файл в соответствии с требованиями Ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.
```
def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )
```
**Шаг 4.** Проверьте module на исполняемость локально.
```
(venv) yura@Skynet ansible % python3 -m ansible.modules.my_own_module payload.json

{"changed": false, "original_message": "Hello world\n", "message": "", "invocation": {"module_args": {"path": "/opt/test.txt", "content": "Hello world\n"}}}
```
**Шаг 5.** Напишите single task playbook и используйте module в нём.
```
---
- name: Testing my module
  hosts: localhost
  gather_facts: false
  tasks: 
    - name: Run my module
      my_own_module:
        path: "/opt/test.txt"
        content: "Hello, my freind!\n"
      
```
**Шаг 6.** Проверьте через playbook на идемпотентность.
```
(venv) yura@Skynet ansible % ansible-playbook test_module.yml -v
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the
Ansible engine, or trying out features under development. This is a rapidly changing source of code and can become unstable at
any point.
No config file found; using defaults
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [Testing my module] *********************************************************************************************************

TASK [Run my module] *************************************************************************************************************
ok: [localhost] => {"changed": false, "message": "", "original_message": "Hello, my freind!\n"}

PLAY RECAP ***********************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
**Шаг 7.** Выйдите из виртуального окружения.
```
(venv) yura@Skynet ansible % deactivate
yura@Skynet ansible %
```
**Шаг 8.** Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`.
```
yura@Skynet ansible % ansible-galaxy collection init my_own_namespace.yandex_cloud_elk
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the
Ansible engine, or trying out features under development. This is a rapidly changing source of code and can become unstable at
any point.
- Collection my_own_namespace.yandex_cloud_elk was created successfully
```
**Шаг 9.** В эту collection перенесите свой module в соответствующую директорию.
<p align="center">
  <img src="./Screenshots/1.png">
</p>  

**Шаг 10.** Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module.
```
yura@Skynet ansible % cd my_own_namespace/yandex_cloud_elk/roles
yura@Skynet roles % ansible-galaxy role init my_role
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel" if you are modifying the
Ansible engine, or trying out features under development. This is a rapidly changing source of code and can become unstable at
any point.
- Role my_role was created successfully
```
[my_role](https://github.com/kibernetiq/my_own_collection/tree/main/yandex_cloud_elk/roles/my_role)  
**Шаг 11.** Создайте playbook для использования этой role.  
[test_module_playbook.yml](https://github.com/kibernetiq/my_own_collection/blob/main/yandex_cloud_elk/test_module_playbook.yml)  
**Шаг 12.** Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.  
[yandex_cloud_elk/README.md](https://github.com/kibernetiq/my_own_collection/blob/main/yandex_cloud_elk/README.md)  
**Шаг 13.** Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.
```
yura@Skynet yandex_cloud_elk % ansible-galaxy collection build
Created collection for my_own_namespace.yandex_cloud_elk at /Users/yura/DevOps_Netology/my_own_namespace/yandex_cloud_elk/my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz
```
**Шаг 14.** Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.

**Шаг 15.** Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`.
```
yura@Skynet new_catalog % ansible-galaxy collection install my_own_namespace-yandex_cloud_elk-1.0.0.tar.gz
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'my_own_namespace.yandex_cloud_elk:1.0.0' to '/Users/yura/.ansible/collections/ansible_collections/my_own_namespace/yandex_cloud_elk'
my_own_namespace.yandex_cloud_elk:1.0.0 was installed successfully
```
**Шаг 16.** Запустите playbook, убедитесь, что он работает.
```
yura@Skynet new_catalog % cd /Users/yura/.ansible/collections/ansible_collections/my_own_namespace/yandex_cloud_elk
yura@Skynet yandex_cloud_elk % ls -l
total 48
-rw-r--r--@ 1 yura  staff  4457 Jul 19 19:53 FILES.json
-rw-r--r--@ 1 yura  staff   738 Jul 19 19:53 MANIFEST.json
-rw-r--r--@ 1 yura  staff   938 Jul 19 19:53 README.md
drwxr-xr-x@ 2 yura  staff    64 Jul 19 19:53 docs
drwxr-xr-x@ 3 yura  staff    96 Jul 19 19:53 meta
drwxr-xr-x@ 4 yura  staff   128 Jul 19 19:53 plugins
drwxr-xr-x@ 3 yura  staff    96 Jul 19 19:53 roles
-rw-r--r--@ 1 yura  staff   204 Jul 17 21:10 test_module.yml
-rw-r--r--@ 1 yura  staff   101 Jul 19 19:53 test_module_playbook.yml
yura@Skynet yandex_cloud_elk % ansible-playbook test_module.yml
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match
'all'

PLAY [Testing my module] *************************************************************************************************

TASK [Run my module] *****************************************************************************************************
ok: [localhost]

PLAY RECAP ***************************************************************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
**Шаг 17.** В ответ необходимо прислать ссылки на collection и tar.gz архив, а также скриншоты выполнения пунктов 4, 6, 15 и 16.
[collection](https://github.com/kibernetiq/my_own_collection/releases/tag/v1.0.0)