#!/bin/bash

ROOT_PATH="$(dirname "$0")"
LIB_FILE=${ROOT_PATH}/app/.utils.sh
ISSUES_PATH=${ROOT_PATH}/issues
ISSUE_RUN_NUMBER=$1
ISSUES_TOTAL_COUNT=1

	# Чистим терминал от ненужного текста
	clear

	# Проверка на наличичие файла-библиотеки app/.utils.sh
	if [ ! -f ${LIB_FILE} ]; then
		echo ".utils lib file not found! Application error"
		exit 1
	fi
	
	source ${LIB_FILE}
	cmd_echo_success "Тестовые задания"
	cmd_echo_success "------------------------------------------------------------"
	
	# Список заданий
	ISSUES_LIST=$( ls ${ROOT_PATH}/issues/)
	for ((i=0; i<${#ISSUES_LIST[@]}; i++)); do
		cmd_echo_warning " ${ISSUES_LIST[$i]} \r\n"
	done
	
	# Выбираем задание со списка
	if [ -z "$ISSUE_RUN_NUMBER" ]; then
		read -p "Выберите номер задания, результат которого Вам нужно получить: " issue
	echo
	else
		issue=1
	fi
	
	# Если номер задания не введен - берем первое
	if [ -z "$issue" ]; then
        cmd_echo_error "Задание не выбрано. Используется первое задание (1)"
        issue=1
	fi
	
	# Загрузка и выполнение выбранного задания
	BOOTSTRAP_ISSUE_FOLDER=${ISSUES_PATH}/${issue}
	source ${BOOTSTRAP_ISSUE_FOLDER}/.issue.sh
	boot ${BOOTSTRAP_ISSUE_FOLDER}