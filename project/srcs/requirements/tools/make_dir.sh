#!/bin/bash

#script for creating folders in home dir

if [ ! -d "/home/${USER}/data" ]; then
        mkdir ~/data
        mkdir ~/data/mariadb
        mkdir ~/data/wordpress
        mkdir ~/data/portainer
fi