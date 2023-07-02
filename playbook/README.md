# Описание
Playbook выполняет установку и запуск приложений на указанных группах серверов из inventory.

## Clickhouse
  - Установка `clickhouse`
  - Создание БД и таблицы


## Vector
  - Установка `vector`

# Variables
Для каждой группы серверов в group_vars можно задавать переменные:
- `clickhouse_version`, `vector_version` - версии устанавливаемых приложений;
- `clickhouse_packages` - список пакетов для установки clickhouse;