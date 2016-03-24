#!/bin/bash
# chkconfig: 2345 66 36
# /etc/rc.d/init.d/opt/python
# description: spython
#
case "$1" in
  start)
        echo -n "Starting rpycserver: "
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Starting rpycserver ." >>/var/log/python
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        echo start
        cd  /home
        ./rpycserver.py &
        echo "Done."
        echo ""
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Finished." >>/var/log/python
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        touch /var/lock/subsys/python
        ;;
  stop)
        echo -n "Shutting Down rpycserver Listeners: "
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Shutting Down rpycserver." >>/var/log/python
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        echo "python"
        killall -9 rypcserver.py
        echo "Done."
        rm -f /var/lock/subsys/python
        echo "Done."
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        date +"! %T %a %D : Finished." >>/var/log/python
        echo "---------------------------------------------------------------------------------" >>/var/log/python
        ;;
  restart)
        stop
        start
        ;;
  *)
  echo "Usage: python { start | stop | restart }"
  exit 1
esac
exit 0
