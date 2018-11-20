#!/bin/bash

DESCRIPTION="
Задание 1:
Имеется лог nginx в формате combined. Нужно считать следующую статистику и сохранить в файл:\n
a) top10 ip адресов\n
b) top10 URL\n
c) top10 юзерагентов\n
Приложить скрипты и команды."

ISSUE_DESCRIPTION="$DESCRIPTION"
RECORDS_COUNT=10

function print_top_10_ip() {
	echo "Top10 IP:" >> ${ISSUE_OUTPUT_FILE}
	cat ${1} | awk '{ print $1 }' ${ISSUE_INPUT_FILE} | sort -n | uniq -c | sort -nr | head -${RECORDS_COUNT} >> ${ISSUE_OUTPUT_FILE}
}

function print_top_10_url() {
	echo "Top10 URL:" >> ${ISSUE_OUTPUT_FILE}
	cat ${1} | awk '{print $7}' | sort -n | uniq -c | sort -nr | head -${RECORDS_COUNT} >> ${ISSUE_OUTPUT_FILE}
}

function print_top_10_user_agents() {
	echo "Top10 User-Agent:" >> ${ISSUE_OUTPUT_FILE}
	cat ${1} | awk -F"\"" '{ print $6 }' ${ISSUE_INPUT_FILE} | sort -n | uniq -c | sort -nr | head -${RECORDS_COUNT} >> ${ISSUE_OUTPUT_FILE}
}

function boot() {
	# Путь к папке с заданием
	ABS_PATH=$1
	
	# Лог-файл
	ISSUE_INPUT_FILE=${ABS_PATH}/access.log
	ISSUE_OUTPUT_FILE=${ABS_PATH}/result.log
	echo -e ${ISSUE_DESCRIPTION}
	truncate -s 0 ${ISSUE_OUTPUT_FILE}
	
	print_top_10_ip ${ISSUE_INPUT_FILE}
	print_top_10_url ${ISSUE_INPUT_FILE}
	print_top_10_user_agents ${ISSUE_INPUT_FILE}
	result_saved_to_file ${ISSUE_OUTPUT_FILE}
}