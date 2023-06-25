# Домашнее задание к занятию 1 «Введение в Ansible»
## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
```
TASK [Print fact] ************************
ok: [localhost] => {
    "msg": 12
}
```
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
<p align="center">
  <img src="./screenshots/1.png">
</p>

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
[docker-compose.yml]()
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
<p align="center">
  <img src="./screenshots/2.png">
</p>

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
<p align="center">
  <img src="./screenshots/3.png">
</p>

<p align="center">
  <img src="./screenshots/4.png">
</p>

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
<p align="center">
  <img src="./screenshots/5.png">
</p>

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
<p align="center">
  <img src="./screenshots/6.png">
</p>

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
<p align="center">
  <img src="./screenshots/7.png">
</p>

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
```
yura@Skynet playbook % ansible-doc -t connection -l
ansible.builtin.local          execute on controller
```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
<p align="center">
  <img src="./screenshots/8.png">
</p>

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
<p align="center">
  <img src="./screenshots/9.png">
</p>

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
OK