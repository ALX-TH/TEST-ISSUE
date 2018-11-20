#!/bin/bash

RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
YELLOW=`tput setaf 3`
BOLD=`tput bold`
RESET=`tput sgr0`

function cmd_echo() {
	CMD_COLOR=${1}
	echo -e "${CMD_COLOR}"$*"${RESET}"
}

function cmd_echo_success() {
	cmd_echo ${GREEN} ${1}
}

function cmd_echo_warning() {
	cmd_echo ${YELLOW} ${1}
}

function cmd_echo_error() {
	cmd_echo ${RED} ${1}
}

function log_append() {
	printf '%s\n' "${1}"
}

function result_saved_to_file() {
	cmd_echo_warning "Результат сохранен в файл ${1}. Введите команду: cat ${1}, чтоб посмотреть результат"
}

function array_to_file() {
    printf "%s\n" ${1} > ${2}
}

function if_exist() {
    command -v "$1" >/dev/null 2>&1
}

function check_cmd() {
    CMD=${1}
    if if_exist ${CMD}; then
      echo "${CMD} binary exist"
    else
      echo "${CMD} binary not exist"
      exit 1
    fi
}

function array_reverse() {
    declare arr="$1" rev="$2"
    for i in "${arr[@]}"
    do
        rev=("$i" "${rev[@]}")
    done
}