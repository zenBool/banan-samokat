#!/bin/zsh

# Создание основных директорий
mkdir -p \
    shared/shared/models \
    shared/shared/migrations/versions \
    trading_bot/trading_bot/tests \
    web_app/web_app/tests \
    telegram_bot/telegram_bot/tests \
    .github/workflows \
    db \
    rabbitmq \
    scripts \
    docs

# Создание файлов в корневом каталоге
touch docker-compose.yml .gitignore README.md .env.example Makefile setup.cfg pyproject.toml

# Создание файлов в shared/
touch shared/pyproject.toml
touch shared/shared/__init__.py shared/shared/database.py shared/shared/utils.py
touch shared/shared/models/__init__.py shared/shared/models/trade.py
touch shared/shared/migrations/env.py shared/shared/migrations/script.py.mako

# Создание файлов в trading_bot/
touch trading_bot/pyproject.toml trading_bot/poetry.lock trading_bot/Dockerfile trading_bot/README.md
touch trading_bot/trading_bot/__init__.py trading_bot/trading_bot/main.py trading_bot/trading_bot/services.py trading_bot/trading_bot/config.py trading_bot/trading_bot/models.py
touch trading_bot/trading_bot/tests/__init__.py trading_bot/trading_bot/tests/test_main.py

# Создание файлов в web_app/
touch web_app/pyproject.toml web_app/poetry.lock web_app/Dockerfile web_app/README.md
touch web_app/web_app/__init__.py web_app/web_app/main.py web_app/web_app/routes.py web_app/web_app/config.py web_app/web_app/models.py
touch web_app/web_app/tests/__init__.py web_app/web_app/tests/test_routes.py

# Создание файлов в telegram_bot/
touch telegram_bot/pyproject.toml telegram_bot/poetry.lock telegram_bot/Dockerfile telegram_bot/README.md
touch telegram_bot/telegram_bot/__init__.py telegram_bot/telegram_bot/main.py telegram_bot/telegram_bot/handlers.py telegram_bot/telegram_bot/config.py telegram_bot/telegram_bot/models.py
touch telegram_bot/telegram_bot/tests/__init__.py telegram_bot/telegram_bot/tests/test_handlers.py

# Создание файлов в db/
touch db/init.sql

# Создание файлов в rabbitmq/
touch rabbitmq/rabbitmq.conf rabbitmq/README.md

# Создание файлов в scripts/
touch scripts/README.md scripts/migrate.sh

# Создание файлов в docs/
touch docs/index.md docs/architecture.md docs/api.md

# Создание файлов в .github/
touch .github/workflows/ci.yml

echo "Структура проекта успешно создана."

