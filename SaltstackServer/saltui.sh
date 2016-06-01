#!/bin/bash
# chkconfig: 2345 66 36
# /etc/init.d/salui
# description: halite
#
case "$1" in
  start)
        echo -n "Starting saltui: "
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Starting saltui ." >>/var/log/saltui
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        echo start
        cd  /var/www/halite/halite/
        python server_bottle.py -d -C -l debug -s cherrypy &
        echo "Done."
        echo ""
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Finished." >>/var/log/saltui
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        touch /var/lock/subsys/saltui
        ;;
  stop)
        echo -n "Shutting Down saltui Listeners: "
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Shutting Down saltui." >>/var/log/saltui
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        echo "saltui"
        killall -9 server_bottle.py
        echo "Done."
        rm -f /var/lock/subsys/saltui
        echo "Done."
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Finished." >>/var/log/saltui
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        ;;
  restart)
        stop
        start
        ;;
  *)
  echo "Usage: service saltui { start | stop | restart }"
  exit 1
esac
exit 0
