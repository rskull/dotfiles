#!/bin/bash

HOST=$1
USER=$2
PASS=$3
PORT=$4
LOCAL_PATH=$5
REMOTE_PATH=$6

set timeout 5
scp -P ${PORT} ${LOCAL_PATH} ${HOST}:${REMOTE_PATH}
