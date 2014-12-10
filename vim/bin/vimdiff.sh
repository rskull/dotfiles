#!/bin/bash

LOCAL_PATH=$1
HOST=$2
USER=$3
PASS=$4
PORT=$5
REMOTE_PATH=$6

set timeout 5
ssh -p ${PORT} ${USER}@${HOST} cat ${REMOTE_PATH} > tmp
vimdiff ${LOCAL_PATH} tmp
rm tmp
