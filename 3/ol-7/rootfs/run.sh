#!/bin/bash

_forwardTerm () {
    echo "Caugth signal SIGTERM, passing it to child processes..."
    pgrep -P $$ | xargs kill -15 2>/dev/null
    wait
    exit $?
}

trap _forwardTerm TERM

# Adding cron entries
ln -fs /opt/bitnami/moodle/conf/cron /etc/cron.d/moodle

/usr/sbin/crond
echo "Starting Apache..."
exec httpd -f /opt/bitnami/apache/conf/httpd.conf -D FOREGROUND
