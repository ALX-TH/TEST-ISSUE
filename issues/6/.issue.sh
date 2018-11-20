#!/bin/bash

DESCRIPTION="
Написать скрипт который будет бекапить все базы mysql, кроме системных и c помощью утилиты rsync копировать на удаленный сервер.\n
Скрипт должен проверять все параметры и обрабатывать возможные ошибки. "

ISSUE_DESCRIPTION="$DESCRIPTION"

function process() {
    INPUT_FILE=${1}
    OUTPUT_FILE=${2}
    truncate -s 0 ${OUTPUT_FILE}

    # Загрузка конфига и проверка установленных пакетов
	source ${INPUT_FILE}
	check_cmd "mysql"
	check_cmd "mysqldump"
	check_cmd "tar"
	check_cmd "ssh"
	check_cmd "rsync"

	# Пофайловый дамп каждой базы кроме системной
    if [ "${MYSQL_MAKE_BACKUP}" = "true" ]
    then
        MYSQL_TMP_DIR=${ABS_PATH}/${MYSQL_WORKING_DIRECTORY}
        rm -rf ${MYSQL_TMP_DIR} &>/dev/null && mkdir -p ${MYSQL_TMP_DIR} &>/dev/null
        for DATABASE in $(mysql --user=${MYSQL_USER} --password=${MYSQL_PASS} --host=${MYSQL_HOST} --execute='show databases;' | grep -Ev "^(Database|mysql|information_schema|performance_schema|phpmyadmin)$")
        do
           cmd_echo_success "[MYSQL]: processing database $DATABASE" >> ${OUTPUT_FILE}
           mysqldump --host=${MYSQL_HOST} --user=${MYSQL_USER} --password=${MYSQL_PASS} --default-character-set=utf8 -N --routines -r ${MYSQL_TMP_DIR}/${DATABASE}.sql ${DATABASE}
        done

          # Создаем архив с базами
          MYSQL_TAR_FILE=${ABS_PATH}/mysql.tar.gz
          tar -zcvf ${MYSQL_TAR_FILE} ${MYSQL_TMP_DIR}

          # Выгружаем архив на удаленный сервер по логину и паролю
          rsync -r -a -v -e ssh --delete ${MYSQL_TAR_FILE} ${RSYNC_USER}@${RSYNC_HOST}:${RSYNC_REMOTE_DIR}

          # Удаляем sql файлы и временную папку
          rm -rf ${MYSQL_TMP_DIR} && rm -rf ${MYSQL_TAR_FILE} &>/dev/null
    fi

    # Отображаем лог в консоль
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