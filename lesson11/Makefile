SHELL := /usr/bin/env bash

.PHONY: all check run1 run2 demo clean

all: check

check:
 @command -v shellcheck >/dev/null 2>&1 || { echo "Установите shellcheck (sudo apt install shellcheck)"; exit 1; }
 shellcheck -x lesson11/script1.sh lesson11/script2.sh

run1:
 chmod +x lesson11/script1.sh
 ./lesson11/script1.sh

run2:
 chmod +x lesson11/script2.sh
 ./lesson11/script2.sh

demo: check
 @echo "— демо: произвольный порядок запусков"
 ./lesson11/script2.sh || true
 ./lesson11/script1.sh
 ./lesson11/script2.sh
 ./lesson11/script1.sh
 @echo "Содержимое ~/myfolder:"
 ls -l "$$HOME/myfolder" || true

clean:
 rm -rf "$$HOME/myfolder"
