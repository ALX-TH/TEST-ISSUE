#!/bin/bash

DESCRIPTION="
Задание 4:\n
имеется файл с содержимым вида:\n
username1\n
somepass\n
8.8.8.8\n
user2\n
pass2\n
127.0.0.1\n

Нужно командой или скриптом привести данный файл к виду:\n
username1:somepass 8.8.8.8\n
user2:pass2 127.0.0.1\n

Команда или скрипт должны корректно обработать любое количество записей."

ISSUE_DESCRIPTION="$DESCRIPTION"

function process() {
    INPUT_FILE=${1}
    OUTPUT_FILE=${2}
    truncate -s 0 ${OUTPUT_FILE}

    # Читаем файл по 3 строки в цикле
    while mapfile -t -n 3 array && ((${#array[@]})); do

        eval $(echo "${array[@]}" | awk '{print "USER=" $1 "; PASS=" $2 "; IP=" $3 }')
        echo "${USER}:" "${PASS}" "${IP}" >> ${OUTPUT_FILE}

    done <  ${INPUT_FILE}
}

function boot() {
	# Путь к папке с заданием
	ABS_PATH=$1
	ISSUE_INPUT_FILE=${ABS_PATH}/source.txt
	ISSUE_OUTPUT_FILE=${ABS_PATH}/result.log
	cmd_echo_success "${ISSUE_DESCRIPTION}"

	process ${ISSUE_INPUT_FILE} ${ISSUE_OUTPUT_FILE}
	result_saved_to_file ${ISSUE_OUTPUT_FILE}

}