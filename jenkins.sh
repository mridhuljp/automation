#!/bin/bash

JENKINS_HOME = /mnt/jenkins
BACKUP_HOME = /root/jenkins

stop ()
{
	/etc/init.d/jenkins stop
}

sync()
{
	echo -e "sync started at `date`" >> /var/log/jenkins/jenkins-sync.log
	/bin/rsync -avz $JENKINS_HOME $BACKUP_HOME
}

start()
{
	/etc/init.d/jenkins start
}

verify(before,after)
{
	if [ after >= before ];then
		echo -e "Backup SUCCESS at `date`" >> /var/log/jenkins/jenkins-sync.log
		return true
	else
		echo -e "Backup FAILED at `date`" >> /var/log/jenkins/jenkins-sync.log
		return false
}

action()
{
	stop
	size_initial = `du -sc $BACKUP_HOME`
	sync
	size_synced = `du -sc $BACKUP_HOME`
	status = verify(size_initial,size_synced)
	start

}

if [ -d /root/jenkins];then
	action

else
	mkdir -p /root/jenkins
	action
	
fi
