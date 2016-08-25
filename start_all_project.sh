#!/bin/bash
#this script execute in /etc/rc.local
#auth:jiajianjun
username=gcweb
user_home=`cat /etc/passwd|grep ${username}|cut -f6 -d':'`
task_list=`find ${user_home}/usr/local/* -iname startup.sh`
#skip_project=(blackname1 blackname2)
for i in ${task_list}
do
	su - gcweb -c "$i"
	sleep 5
done
#start redis server
su - gcweb -c "redis-server /etc/redis.conf"
su - gcweb -c "redis-server /etc/redis_hw_6381.conf"
su - gcweb -c "redis-server /etc/redis_zs_6380.conf"
#start jenkins server
su - gcweb -c "java -jar /home/gcweb/home/jenkins/ROOT/jenkins.war --httpPort=12473 &"
