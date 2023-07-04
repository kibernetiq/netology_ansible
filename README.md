# Домашнее задание к занятию 2 «Работа с Playbook»
## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.  
[prod.yml](https://github.com/kibernetiq/ansible_test/blob/main/playbook/inventory/prod.yml)

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).  
[site.yml#L41-L61](https://github.com/kibernetiq/ansible_test/blob/main/playbook/site.yml#L41-L61)  

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
yura@Skynet playbook % ansible-lint site.yml

Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
yura@Skynet playbook % ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] ************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************
Enter passphrase for key '/Users/yura/.ssh/id_rsa':
ok: [clickhouse-01]

TASK [Download clickhouse packages] **************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "yura", "item": "clickhouse-common-static", "mode": "01204", "msg": "Request failed", "owner": "yura", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Download clickhouse-common-static packages] ************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ****************************************************************************************************************************

TASK [Create database] ***************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************
Enter passphrase for key '/Users/yura/.ssh/id_rsa':
ok: [vector-01]

TASK [Get Vector distrib] ************************************************************************************************************************
ok: [vector-01]

TASK [Install Vector packages] *******************************************************************************************************************
ok: [vector-01]

PLAY RECAP ***************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
yura@Skynet playbook % ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************
Enter passphrase for key '/Users/yura/.ssh/id_rsa':
ok: [clickhouse-01]

TASK [Download clickhouse packages] **************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "yura", "item": "clickhouse-common-static", "mode": "01204", "msg": "Request failed", "owner": "yura", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Download clickhouse-common-static packages] ************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ****************************************************************************************************************************

TASK [Create database] ***************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************
Enter passphrase for key '/Users/yura/.ssh/id_rsa':
ok: [vector-01]

TASK [Get Vector distrib] ************************************************************************************************************************
ok: [vector-01]

TASK [Install Vector packages] *******************************************************************************************************************
ok: [vector-01]

PLAY RECAP ***************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
Вывод идентичен 7 пункту.

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
[playbook/README.md](https://github.com/kibernetiq/ansible_test/blob/main/playbook/README.md)  






- 6. Попробуйте запустить playbook на этом окружении с флагом --check.
```
yura@Skynet playbook % ansible-playbook -i inventory/prod.yml site.yml --check -v

...
...

TASK [Lighthouse | Install epel-release] **********************************************************************************************************
skipping: [lighthouse-01] => {"changed": false, "cmd": ["sudo", "yum", "install", "epel-release", "&&", "sudo", "yum", "update", "-y"], "delta": null, "end": null, "msg": "Command would have run if not in check mode", "rc": 0, "start": null, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

TASK [Lighthouse | Install Nginx] *****************************************************************************************************************
skipping: [lighthouse-01] => {"changed": false, "cmd": ["sudo", "yum", "install", "nginx"], "delta": null, "end": null, "msg": "Command would have run if not in check mode", "rc": 0, "start": null, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

TASK [Lighthouse | Start Nginx] *******************************************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service nginx: host"}

PLAY RECAP ****************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0
lighthouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=2    rescued=0    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


