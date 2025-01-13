#!/usr/bin/bash
# Скрипт для настройки рабочего окружения в ОС RosaLinux\МОС


if dnf list installed python3.11 >/dev/null 2>&1; then
    echo "Обнаружена требуемая версия Python"
else
    echo "Не установлен python требуемой версии! Произведите установку:"
    sudo dnf install -y python3.11
fi

/usr/libexec/python3.11 -m venv env
source ./env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

printf '\n Для продолжения работы в IDE не забудьте активировать venv `source ./env/bin/activate` и выбрать локальную версию интерпретатора'