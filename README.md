1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.  
[Install + config LightHouse ](https://github.com/kibernetiq/ansible_test/blob/main/playbook/site.yml#L63-L105)
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
yura@Skynet playbook % ansible-lint site.yml

Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
yura@Skynet playbook % ansible-playbook  site.yml --check
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'
[WARNING]: Could not match supplied host pattern, ignoring: clickhouse

PLAY [Install Clickhouse] ********************************************************************************************************
skipping: no hosts matched
[WARNING]: Could not match supplied host pattern, ignoring: vector

PLAY [Install Vector] ************************************************************************************************************
skipping: no hosts matched
[WARNING]: Could not match supplied host pattern, ignoring: lighthouse

PLAY [Install lighthouse] ********************************************************************************************************
skipping: no hosts matched

PLAY RECAP ***********************************************************************************************************************

```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
yura@Skynet playbook % ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ********************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [clickhouse-01]

TASK [Download clickhouse packages] **********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "yura", "item": "clickhouse-common-static", "mode": "01204", "msg": "Request failed", "owner": "yura", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Download clickhouse-common-static packages] ********************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***********************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ************************************************************************************************************

TASK [Create database] ***********************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [vector-01]

TASK [Get Vector distrib] ********************************************************************************************************
ok: [vector-01]

TASK [Install Vector packages] ***************************************************************************************************
ok: [vector-01]

PLAY [Install lighthouse] ********************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install git] **************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install epel-release] *****************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install Nginx] ************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Clone repository] *********************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Apply config] *************************************************************************************************
ok: [lighthouse-01]

PLAY RECAP ***********************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
lighthouse-01              : ok=6    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
yura@Skynet playbook % ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ********************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [clickhouse-01]

TASK [Download clickhouse packages] **********************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "yura", "item": "clickhouse-common-static", "mode": "01204", "msg": "Request failed", "owner": "yura", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Download clickhouse-common-static packages] ********************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***********************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ************************************************************************************************************

TASK [Create database] ***********************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [vector-01]

TASK [Get Vector distrib] ********************************************************************************************************
ok: [vector-01]

TASK [Install Vector packages] ***************************************************************************************************
ok: [vector-01]

PLAY [Install lighthouse] ********************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install git] **************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install epel-release] *****************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Install Nginx] ************************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Clone repository] *********************************************************************************************
ok: [lighthouse-01]

TASK [Lighthouse | Apply config] *************************************************************************************************
ok: [lighthouse-01]

PLAY RECAP ***********************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
lighthouse-01              : ok=6    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
[playbook/README.mb](https://github.com/kibernetiq/ansible_test/blob/main/playbook/README.md)
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.