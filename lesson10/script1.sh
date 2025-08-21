#!/usr/bin/env bash

set -u

DIR="${HOME}/myfolder"
F1="${DIR}/file1.txt"
F2="${DIR}/file2.txt"
F3="${DIR}/file3.txt"
F4="${DIR}/file4.txt"
F5="${DIR}/file5.txt"

# Папка
mkdir -p "$DIR"

# file1: две строки — приветствие и текущее время
{
  printf '%s\n' "Привет!"
  date +"Дата/время: %Y-%m-%d %H:%M:%S %Z"
} > "$F1"

# file2: пустой + права 777 (игнорируем возможные ограничения ФС)
: > "$F2"
chmod 0777 "$F2" 2>/dev/null || true

# file3: одна строка из 20 случайных символов
rand_line="$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 20 || true)"
# запасной вариант, если /dev/urandom недоступен
if [ -z "${rand_line}" ]; then
  rand_line="$(date +%s%N | sha256sum | head -c 20)"
fi
printf '%s\n' "$rand_line" > "$F3"

# file4 и file5: пустые
: > "$F4"
: > "$F5"

echo "script1.sh: готово — файлы созданы/обновлены в $DIR"
