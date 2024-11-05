#!/bin/bash

# Script from ChatGPT
# Alternative  #jb:$_ tree

# Проверка, передан ли хотя бы один аргумент
if [ $# -lt 1 ]; then
    echo "Использование: $0 <путь_к_папке> [исключения...]"
    echo "Пример: $0 /path/to/dir .git node_modules *.tmp"
    exit 1
fi

DIRECTORY=$1
shift

# Сбор исключений в массив
EXCLUDES=("$@")

# Проверка, существует ли указанный путь и является ли он директорией
if [ ! -d "$DIRECTORY" ]; then
    echo "Ошибка: '$DIRECTORY' не является существующей директорией."
    exit 1
fi

# Цвета
GREEN='\033[0;32m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Функция для проверки, должен ли элемент быть исключен
should_exclude() {
    local ITEM=$1
    for PATTERN in "${EXCLUDES[@]}"; do
        if [[ "$ITEM" == $PATTERN ]]; then
            return 0
        fi
    done
    return 1
}

# Функция для рекурсивного отображения дерева
print_tree() {
    local DIR=$1
    local PREFIX=$2

    # Получение списка элементов, исключая указанные
    local ELEMENTS=()

    if [ ${#EXCLUDES[@]} -gt 0 ]; then
        # Строим выражение для find с исключениями
        local FIND_EXPRESSION=""
        for PATTERN in "${EXCLUDES[@]}"; do
            FIND_EXPRESSION+=" -name '$PATTERN' -o"
        done
        # Удаляем последний -o
        FIND_EXPRESSION=${FIND_EXPRESSION% -o}

        # Выполняем find с исключениями
        while IFS= read -r -d $'\0' item; do
            ITEM_NAME=$(basename "$item")
            ELEMENTS+=("$ITEM_NAME")
        done < <(find "$DIR" -mindepth 1 -maxdepth 1 \( $FIND_EXPRESSION \) -prune -o -print0 | sort -z)
    else
        # Если исключений нет, просто находим все элементы
        while IFS= read -r -d $'\0' item; do
            ITEM_NAME=$(basename "$item")
            ELEMENTS+=("$ITEM_NAME")
        done < <(find "$DIR" -mindepth 1 -maxdepth 1 -print0 | sort -z)
    fi

    local COUNT=${#ELEMENTS[@]}
    local INDEX=0

    for ELEMENT in "${ELEMENTS[@]}"; do
        INDEX=$((INDEX + 1))
        local FULL_PATH="$DIR/$ELEMENT"

        # Проверка, является ли элемент директорией
        if [ -d "$FULL_PATH" ]; then
            if [ "$INDEX" -lt "$COUNT" ]; then
                echo -e "${PREFIX}├── ${GREEN}${ELEMENT}/${NC}"
                NEW_PREFIX="${PREFIX}│   "
            else
                echo -e "${PREFIX}└── ${GREEN}${ELEMENT}/${NC}"
                NEW_PREFIX="${PREFIX}    "
            fi
            # Рекурсивный вызов для вложенных директорий
            print_tree "$FULL_PATH" "$NEW_PREFIX"
        else
            if [ "$INDEX" -lt "$COUNT" ]; then
                echo -e "${PREFIX}├── ${WHITE}${ELEMENT}${NC}"
            else
                echo -e "${PREFIX}└── ${WHITE}${ELEMENT}${NC}"
            fi
        fi
    done
}

# Вывод корневой директории
echo -e "${DIRECTORY}/"
# Вызов функции для отображения дерева
print_tree "$DIRECTORY" ""
