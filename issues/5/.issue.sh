#!/bin/bash

DESCRIPTION="
Задание 5:\n
Есть файл вида:\n
word1 12 word11\n
w0rd2 34 woord22\n
wo7d3 56 wo-rd3\n
w07d4 78 wurd44\n
w07d5 90 wurd5\n\n

Нужно скриптом или командой привести к виду:\n
w07d5 12 wurd5\n
w07d4 34 wurd44\n
wo7d3 56 wo-rd3\n
w0rd2 78 woord22\n
word1 90 word11\n\n

Где крайние значения должны отсортироваться в обратном порядке, а средние остаться на своем месте.\n
Команда или скрипт должны корректно обработать любое количество записей."

ISSUE_DESCRIPTION="$DESCRIPTION"

function process() {
    INPUT_FILE=${1}
    OUTPUT_FILE=${2}
    truncate -s 0 ${OUTPUT_FILE}

    # Построение массива из файла
    mapfile -t DATA < ${INPUT_FILE}

    # Разбиваем массив на колонки
    ARR_C1=()
    ARR_C2=()
    ARR_C3=()
    iteration=0
    for each in "${DATA[@]}"
    do
        eval $(echo ${each} | awk '{print "COL1=" $1 "; COL2=" $2 "; COL3=" $3 }')
        ARR_C1[iteration]=$(printf '%s' "${COL1}")
        ARR_C2[iteration]=$(printf '%d' "${COL2}")
        ARR_C3[iteration]=$(printf '%s' "${COL3}")
        ((iteration++))
    done

    # Переворачиваем массивы 1 и 3
    ARR_1=()
    ARR_3=()
    for ((i=iteration; i>=0; i--))
    do
        ARR_1+=($(printf '%s' ${ARR_C1[$i]}))
        ARR_3+=($(printf '%s' ${ARR_C3[$i]}))
    done

    # Создаем новый массив
    for (( c=0; c<=${iteration}; c++ ))
    do
       echo "${ARR_1[$c]}" ${ARR_C2[$c]} "${ARR_3[$c]}" >> ${OUTPUT_FILE}
    done

    cat ${OUTPUT_FILE}
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