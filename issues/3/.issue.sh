#!/bin/bash

DESCRIPTION="
Задание 3:\n
Нужно запретить доступ к сайтам с user-agent Firefox и Chrome, но если у пользователя ip адрес 8.8.8.8, также если HTTP-referer будет google.com, yandex.ru или test.com, то доступ нужно разрешить\n
Вместо 8.8.8.8 можно использовать свой домашний ip.\n
Сделать нужно в конфиге nginx\n

Смотреть нужно в сторону map и if в nginx (предпочтительнее). Так же можно придумать вариант с использованием set\n

Может пригодится документация и Google :)\n
http://nginx.org/ru/docs/http/ngx_http_map_module.html\n
http://nginx.org/ru/docs/http/ngx_http_rewrite_module.html#if\n
http://nginx.org/ru/docs/http/ngx_http_rewrite_module.html#set\n"

ISSUE_DESCRIPTION="$DESCRIPTION"

function boot() {
	# Путь к папке с заданием
	ABS_PATH=$1

	cmd_echo_success "${ISSUE_DESCRIPTION}"
	cmd_echo_warning "Перейдите в каталог ${ABS_PATH}. В директории conf лежит конфигурация для NGINX, которая выполнена согласно заданию\n
	Запустить скрипт и апстримы можно через docker, выполнив команду:\n docker-compose build --force && docker-compose up -d\n
    после чего по адресу http://localhost будет поднят веб-сервер (демонстрация рабочей конфигурации)"

}