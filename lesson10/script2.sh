#!/usr/bin/env bash


set -u

DIR="${HOME}/myfolder"
mkdir -p "$DIR"

# 1) Сколько файлов сейчас
count="$(find "$DIR" -mindepth 1 -maxdepth 1 -type f 2>/dev/null | wc -l | awk '{print $1}')"
echo "script2.sh: файлов в ${DIR}: ${count}"

# 2) Права у второго файла
if [ -e "${DIR}/file2.txt" ]; then
  chmod 664 "${DIR}/file2.txt" 2>/dev/null || true
fi

# 3) Удаление пустых файлов
# (print имена удаляемых, но не падаем, если ничего не найдено)
find "$DIR" -maxdepth 1 -type f -empty -print -delete 2>/dev/null || true

# 4) В оставшихся файлах — только первая строка
# Берём только непустые файлы, аккуратно обрабатываем имена с пробелами
while IFS= read -r -d '' f; do
  tmp="$(mktemp)"
  head -n 1 "$f" > "$tmp" || true
  # Если по какой-то причине head ничего не дал — сделаем файл пустым
  if [ -s "$tmp" ]; then
    mv "$tmp" "$f"
  else
    rm -f "$tmp"
    : > "$f"
  fi
done < <(find "$DIR" -maxdepth 1 -type f ! -empty -print0 2>/dev/null)

echo "script2.sh: готово — пустые файлы удалены, в остальных оставлена первая строка."
