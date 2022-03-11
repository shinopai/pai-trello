#!/bin/bash
set -e

rm -f /pai-trello/tmp/pids/server.pid

exec "$@"
