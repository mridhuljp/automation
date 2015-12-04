#!/bin/bash

CF_END_POINT="https://api.de-ams.thunderhead.io"
CF_SPACE="apps"
CF_ORG="cccjenkins"
CF_USER="admin"
CF_PASSWORD="C1sco123="


cf login -a $CF_END_POINT -u $CF_USER -p $CF_PASSWORD -o $CF_ORG -s $CF_SPACE --skip-ssl-validation


for APP in `cf apps |grep chatc-|grep stopped|awk {'print $1'}`;do
	cf delete $APP -f
done

for APP in `cf apps |grep chatm-|grep stopped|awk {'print $1'}`;do
	cf delete $APP -f
done

for APP in `cf apps |grep config-|grep stopped|awk {'print $1'}`;do
	cf delete $APP -f
done

for APP in `cf apps |grep voicec-|grep stopped|awk {'print $1'}`;do
	cf delete $APP -f
done

