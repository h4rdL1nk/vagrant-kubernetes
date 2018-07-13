#!/bin/bash

case $1 in
    "ubuntu")
        apt-get update
        apt-get install -y python
        ;;
    "centos")
        yum update
        yum install -y python
        ;;
    default)
        echo "${1} not supported"
esac