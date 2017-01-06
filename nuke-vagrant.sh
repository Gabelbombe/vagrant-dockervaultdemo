#!/usr/bin/env bash

for PID in $(vagrant global-status |awk '{print$1}' |grep -E ^[a-z0-9]{7}$) ; do vagrant destroy -f $PID; done
