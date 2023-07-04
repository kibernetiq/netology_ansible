# Описание
Playbook выполняет установку и запуск приложений на указанных группах серверов.

## Clickhouse
  - Установка `clickhouse`
  - Создание БД и таблицы
## Vector
  - Установка `vector`
## Lighthouse
  - Установка `nginx`
  - Установка `git`
  - Установка `lighthouse`  
  
  
### Используемые переменные
Для каждой группы серверов в group_vars можно задавать переменные:
- `clickhouse_version`, `vector_version` - версии устанавливаемых приложений;
- `clickhouse_packages` - список пакетов для установки clickhouse;
- `lighthouse_url` - ссылка на репозиторий;
- `lighthouse_dir` - рабочий каталог сервиса;
- `lighthouse_nginx_user` - пользователь под которым запущен nginx;
- `lighthouse_nginx_dir` - путь куда нужно положить nginx шаблон

