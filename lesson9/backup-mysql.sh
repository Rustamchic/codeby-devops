#!/usr/bin/env bash
set -Eeuo pipefail

BACKUP_DIR="/opt/mysql_backup"
RETENTION_DAYS=7
DB_LIST=("shop")        # какие БД бэкапим; пусто => все базы
MYSQL_DEFAULTS="/home/backupuser/.my.cnf"

timestamp="$(date +'%Y%m%d-%H%M%S')"
host="$(hostname -s)"
log() { echo "[mysql-backup] $*"; }

mkdir -p "$BACKUP_DIR"

dump_db() {
  local db="$1"
  local out="${BACKUP_DIR}/${host}_${db}_${timestamp}.sql.gz"
  log "dump $db -> $out"
  mysqldump \
    --defaults-file="$MYSQL_DEFAULTS" \
    --single-transaction --routines --triggers --events \
    --databases "$db" | gzip -9 > "$out"
}

if [ "${#DB_LIST[@]}" -eq 0 ]; then
  out="${BACKUP_DIR}/${host}_all_${timestamp}.sql.gz"
  log "dump ALL -> $out"
  mysqldump \
    --defaults-file="$MYSQL_DEFAULTS" \
    --single-transaction --routines --triggers --events \
    --all-databases | gzip -9 > "$out"
else
  for db in "${DB_LIST[@]}"; do dump_db "$db"; done
fi

# Ротация старых бэкапов
find "$BACKUP_DIR" -type f -name '*.sql.gz' -mtime +"$RETENTION_DAYS" -delete

# (синхронизация на store выполняется отдельным таймером mysql-sync.timer)
