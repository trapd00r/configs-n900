#!/bin/sh
#
# Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
#
# Contact: Gabriel Schulhof <gabriel.schulhof@nokia.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA

if [ $# -lt 3 ]; then
  echo "Usage: $0 {start|stop|restart} servicename cmd [params]"
  exit 1
fi

STOP=FALSE
START=FALSE

case "$1" in
start)  START=TRUE
        ;;
stop)   STOP=TRUE
        ;;
restart)
        STOP=TRUE
        START=TRUE
        ;;
*)      echo "Usage: $0 {start|stop|restart} servicename cmd [params]"
        exit 1
        ;;
esac

shift
SVC="$1"
shift
CMD=$1
BASENAME=`basename $CMD`
PIDFILE=$AF_PIDDIR/$BASENAME.pid
shift
PARAMS=$@

if [ $STOP = TRUE ]; then
  echo "Stopping $SVC"
  /usr/sbin/dsmetool -k "$CMD $PARAMS"
fi

if [ $START = TRUE ]; then
  echo "Starting $SVC"
  /usr/sbin/dsmetool -n -1 -t "$CMD $PARAMS"
fi
