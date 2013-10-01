#!/bin/sh
### BEGIN INIT INFO
# Provides:          puma
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage puma server
# Description:       Start, stop, restart puma server for hei-connect-web.
### END INIT INFO
set -e

# Feel free to change any of the following variables for your app:
APP_ROOT=/home/deployer/apps/hei-connect-web
CMD="cd $APP_ROOT; bundle exec puma -C $APP_ROOT/config/puma.rb -b unix://$APP_ROOT/tmp/puma/puma.sock -e production --control unix://$APP_ROOT/tmp/puma/pumactl.sock --state $APP_ROOT/tmp/puma/state --pidfile $APP_ROOT/tmp/puma/puma.pid 2>&1 >> $APP_ROOT/log/puma.log &"
CTL="cd $APP_ROOT; bundle exec pumactl -S $APP_ROOT/tmp/puma/state"
AS_USER=deployer
set -u

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

case "$1" in
start)
  if [ ! -e "$APP_ROOT/tmp/puma/puma.sock" ] 
  then 
    run "$CMD"
    exit 1
  else
    echo >&2 "Already running"
  fi
  ;;
stop)
  [ -e "$APP_ROOT/tmp/puma/puma.sock" ]  && run "$CTL stop" && exit 0
  echo >&2 "Not running"
    ;;
force-stop)
  [ -e "$APP_ROOT/tmp/puma/puma.sock" ]  && run "$CTL halt" && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  [ -e "$APP_ROOT/tmp/puma/puma.sock" ]  && run "$CTL restart" && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  run "$CMD"
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|force-stop>"
  exit 1
  ;;
esac
