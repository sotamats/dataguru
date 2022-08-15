BOT_ID ?= "CVSCARM-A10-000000000"

DATAGURU_CONF ?= "/etc/dataguru"
DATAGURU_LOG  ?= "/var/log/dataguru"

DATAGURU_VER ?= 0.1.0

INST_OPTS ?= --mode=644
LOG_UPLOAD_PATH ?= /tmp/dataguru/log
UPLOAD_PATH := $(shell echo ${LOG_UPLOAD_PATH} | sed 's/\//\\\//g')


all: data-guru

data-guru:
	docker build -f Dockerfile -t dataguru:${DATAGURU_VER} .

install:
	mkdir -p ${DATAGURU_CONF} ${DATAGURU_LOG}
	install ${INST_OPTS} \
		dataguru.conf.lua \
		dataguru.exclude \
		${DATAGURU_CONF}
	sed -i "s/BOT_ID/${BOT_ID}/g" ${DATAGURU_CONF}/dataguru.conf.lua
	install ${INST_OPTS} --mode=666 \
		dataguru.log \
		dataguru-status.log \
		${DATAGURU_LOG}
	install ${INST_OPTS} dataguru.service /etc/systemd/system
	sed -i "s/LOG_UPLOAD_PATH/${UPLOAD_PATH}/g" /etc/systemd/system/dataguru.service
	install ${INST_OPTS} dataguru /etc/logrotate.d
	systemctl daemon-reload
	systemctl enable dataguru.service
	systemctl restart dataguru.service

uninstall:
	systemctl stop dataguru.service
	rm -rf ${DATAGURU_CONF} \
		${DATAGURU_LOG} \
		/etc/systemd/system/dataguru.service \
		/etc/logrotate.d/dataguru
