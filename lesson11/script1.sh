#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'


readonly TARGET_DIR="${HOME}/myfolder"
readonly FILE1="${TARGET_DIR}/file1.txt"
readonly FILE2="${TARGET_DIR}/file2.txt"
readonly FILE3="${TARGET_DIR}/file3.txt"
readonly FILE4="${TARGET_DIR}/file4.txt"
readonly FILE5="${TARGET_DIR}/file5.txt"
readonly RAND_LEN=20



log() { printf '[script1] %s\n' "$*"; }

ensure_dir() {
  mkdir -p "${TARGET_DIR}"
}

write_file1() {
  {
    printf '%s\n' "Привет!"
    date +"Дата/время: %Y-%m-%d %H:%M:%S %Z"
  } > "${FILE1}"
}

create_empty_with_mode() {
  # $1 — путь; $2 — восьмеричные права (например, 0777)
  : > "$1"
  # chmod может быть частично ограничен ФС/umask — это не критично
  chmod "$2" "$1" 2>/dev/null || true
}

gen_random_alnum() {
  # печатает в stdout RAND_LEN символов [A-Za-z0-9]
  # возврат: 0 — успех, 1 — не удалось
  local s
  s="$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c "${RAND_LEN}" || true)"
  if [ -z "${s}" ]; then
    # запасной вариант, если /dev/urandom недоступен
    s="$(date +%s%N | sha256sum | head -c "${RAND_LEN}")"
  fi
  [ -n "${s}" ] || return 1
  printf '%s' "${s}"
  return 0
}

write_random_line() {
  # $1 — путь
  local rnd
  rnd="$(gen_random_alnum)" || return 1
  printf '%s\n' "${rnd}" > "$1"
}

touch_empty() {
  # $1 — путь
  : > "$1"
}

main() {
  log "Создаю каталог: ${TARGET_DIR}"
  ensure_dir

  log "Создаю file1.txt (2 строки)"
  write_file1

  log "Создаю пустой file2.txt с правами 0777"
  create_empty_with_mode "${FILE2}" 0777

  log "Создаю file3.txt (20 случайных символов)"
  write_random_line "${FILE3}"

  log "Создаю пустые file4.txt и file5.txt"
  touch_empty "${FILE4}"
  touch_empty "${FILE5}"

  log "Готово."
}

main "$@"
