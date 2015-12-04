#!/bin/bash

## CONSTANTS
SCRIPT_NAME=`basename $0`
SCRIPT_VERSION=0.1


## Print usage
function Usage() {
    cat<<USAGE

    $SCRIPT_NAME v$SCRIPT_VERSION - SSH to platfoem2.0 components

    Usage:
        $SCRIPT_NAME [-d deployment] [-s service] [-h hostname] [-help] [-l list][-v version]

    Where,
        -d    deployment    Deployment to which you need to ssh.
        -s    service       Servive 
        -h    hostname      Hostname of the server to which you need to ssh
        -help help          You need some help ?
        -l    list          List the servers available
        -v    version       version of script you are running.
    
    Example:
        $SCRIPT_NAME -d stagingtx3 -s logs -h cfv2dea-red-habanero-608-loadtx3-admin.nctx3-load.ciscoccservice.com
USAGE
}

## MAIN

while getopts "d:D:s:S:v:l:hH" OPTION
do
    case $OPTION in
    d|D) DEPLOYMENT=$OPTARG
        ;;
    s|S) SERVICE=$OPTARG
        ;;
    h|H) HOSTNAME=$OPTARG
        ;;
    *)  Usage
        exit 0
        ;;
    esac
done

"""

appName=`grep -w name $MANIFEST_FILE | cut -d: -f2`

if [ -z "$appName" ]
then
    echo "ERROR: Application name could not be inferred"
    exit 1
fi

cf login -a $API_ENDPOINT -u $USER -p $PASSWORD -o $ORG -s $SPACE
cf push -f $MANIFEST_FILE

# set up cloudfoundry route and external DNS aliases
cf map-route $appName ${CLUSTER}.${DOMAIN} -n $appName
cf map-route $appName ${DOMAIN} -n $appName

#ssh $BASTION_SERVER "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID; export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY; cli53 rrcreate $DOMAIN $appName CNAME app.${DOMAIN} --ttl 300 --replace"



