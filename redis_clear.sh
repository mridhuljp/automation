#!/bin/bash

EN=$1
echo $EN
WORK_DIR=/home/mpax/git

if [ $EN == 'load' ];
then
	cd $WORK_DIR/deployment-load/cf-deploy; 
	
else
	echo "Another tenant"
fi