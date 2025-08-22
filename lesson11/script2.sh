#!/usr/bin/env bash


set -Eeuo pipefail
IFS=$'\n\t'


readonly TARGET_DIR="${HOME}/myfolder"
readonly FILE2="${TARGET_DIR}/file2.txt"



log() { printf '[script2] %s\n' "$*"; }

ensure_dir() {
  mkdir -p "${TARGET_DIR}"
}

count_files() {
  # печатает число файлов (уровень 1) в каталоге
  local cnt
  cnt="$(find "${TARGET_DIR}" -mindepth 1 -maxdepth 1 -type f -printf . 2>/dev/null | wc -c)"
  printf '%s\n' "${cnt}"
}

fix_file2_perms() {
  # если file2.txt существует — меняем права на 0664
  if [ -e "${FILE2}" ]; then
    chmod 0664 "${FILE2}" 2>/dev/null || true
  fi
}

delete_empty_files() {
  # удаляем пустые файлы (и печатаем их имена)
  find "${TARGET_DIR}" -maxdepth 1 -type f -empty -print -delete 2>/dev/null || true
}

keep_first_line_only() {
  # Для НЕпустых файлов в каталоге оставляем только первую строку
  # Используем -print0 + read -d '' для безопасности имён
  while IFS= read -r -d '' f; do
    # на случай гонки: файл мог стать пустым — пропускаем
    [ -s "$f" ] || continue
    # временный файл в том же каталоге
    local tmp
    tmp="$(mktemp "${TARGET_DIR}/.tmp.XXXXXX")"
    # пишем только первую строку (sed быстрее/проще)
    sed -n '1p' "$f" > "${tmp}" || true
    if [ -s "${tmp}" ]; then
      mv -f "${tmp}" "$f"
    else
      rm -f "${tmp}"
      : > "$f"
    fi
  done < <(find "${TARGET_DIR}" -maxdepth 1 -type f ! -empty -print0 2>/dev/null)
}

main() {
  ensure_dir

  local cnt
  cnt="$(count_files)"
  log "файлов в ${TARGET_DIR}: ${cnt}"

  log "чиню права file2.txt (если есть) -> 0664"
  fix_file2_perms

  log "удаляю пустые файлы"
  delete_empty_files

  log "в остальных оставляю только первую строку"
  keep_first_line_only

  log "Готово."
}

main "$@"
