#!/bin/sh
kill -0 cat ${OPENSHIFT_RUN_DIR}/redis.pid || ${OPENSHIFT_DATA_DIR}/redis/bin/redis-server ${OPENSHIFT_DATA_DIR}/redis/bin/redis.conf