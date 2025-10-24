#!/bin/bash
export WORKER_NAME=default
export WORKER_PATH=/var/ol/$WORKER_NAME

make ol imgs/ol-min
./ol worker init -p ${WORKER_PATH} -i ol-min
./ol worker up -p ${WORKER_PATH} -d
./ol worker status -p ${WORKER_PATH}

# UDS PID check
curl --unix-socket /var/ol/default/worker/ol.sock http://unix/pid
cat /var/ol/default/worker/worker.pid

# HTTP status
echo 'curl -s http://localhost:5000/registry/'
curl -s http://localhost:5000/registry/
./ol admin install -p /var/ol/default examples/echo/
echo 'curl -s http://localhost:5000/registry/'
curl -s http://localhost:5000/registry/

./ol worker down -p ${WORKER_PATH}