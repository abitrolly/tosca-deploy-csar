#!/bin/bash
# tested on Ubuntu 21.04

# show commands as they are executed
set -x

# enable non-interactive mode to avoid asking questions
# during installation of Python pip installer
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get -y install python3-pip curl

# install xOpera
pip3 install opera
