SHELL = /bin/sh
include ./docker/.env
export
build_all: build_post build_comment build_ui build_prometheus build_alertmanager build_fluentd
build_comment:
	cd ./src/comment && bash ./docker_build.sh

build_post:
	cd ./src/post-py && bash ./docker_build.sh

build_ui:
	cd ./src/ui && bash ./docker_build.sh

build_prometheus:
	cd ./monitoring/prometheus && docker build -f Dockerfile -t $(USER_NAME)/prometheus .

build_alertmanager:
	cd ./monitoring/alertmanager && docker build -f Dockerfile -t $(USER_NAME)/alertmanager .

build_fluentd:
	cd ./logging/fluentd && docker build -f Dockerfile -t $(USER_NAME)/fluentd .

push_all: push_comment push_post push_ui push_prometheus push_alertmanager push_fluentd

push_comment:
	docker push $(USER_NAME)/comment:$(VERS)

push_post:
	docker push ${USER_NAME}/post:$(VERS)

push_ui:
	docker push ${USER_NAME}/ui:$(VERS)

push_prometheus:
	docker push ${USER_NAME}/prometheus:$(VERS)

push_alertmanager:
	docker push ${USER_NAME}/alertmanager:$(VERS)

push_fluentd:
	docker push ${USER_NAME}/fluentd:$(VERS)

up:
	cd ./docker && docker-compose -f docker-compose.yml -f docker-compose-monitoring.yml -f docker-compose-logging.yml up -d

down:
	cd ./docker && docker-compose -f docker-compose.yml -f docker-compose-monitoring.yml -f docker-compose-logging.yml down

stop:
	cd ./docker && docker-compose  -f docker-compose.yml -f docker-compose-monitoring.yml  -f docker-compose-logging.yml stop

purge:
	docker kill $(shell docker ps -q); true
	docker container rm $(shell docker container ls -a -q); true
	docker rmi $(shell docker images -q); true
	docker volume rm $(shell docker volume ls -q); true
	docker network rm $(shell docker network ls -q); true
