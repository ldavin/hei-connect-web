#!/bin/sh
#
# Simple Redis init.d script conceived to work on Linux systems
# as it does use of the /proc filesystem.

REDISSOCKET=${OPENSHIFT_DATA_DIR}/redis/socks/redis.sock
EXEC=${OPENSHIFT_DATA_DIR}redis/bin/redis-server
CLIEXEC=${OPENSHIFT_DATA_DIR}redis/bin/redis-cli

PIDFILE=${OPENSHIFT_DATA_DIR}/redis/pids/redis.pid
CONF=${OPENSHIFT_DATA_DIR}/redis/redis.conf

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                echo "Starting Redis server..."
                $EXEC $CONF
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                PID=$(cat $PIDFILE)
                echo "Stopping ..."
                $CLIEXEC -s $REDISSOCKET shutdown
                while [ -x /proc/${PID} ]
                do
                    echo "Waiting for Redis to shutdown ..."
                    sleep 1
                done
                echo "Redis stopped"
        fi
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac
