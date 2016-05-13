#!/bin/bash
#--------------------------
#   name:update_project
#   type:function
#   language:bash shell
#   date:2016-4-25
#--------------------------

#Make ls -lt --time-style output ture
LANG=en_US.UTF-8

#
current_folder=`pwd`
i=0
x=1
select_num=1
selfile_type=zip

#Time stamp function
function time_stamp(){
        date +%Y%m%d%H%M%S
}

#Get project name
project_name=`echo $current_folder|awk  -F'/' '{print $(NF-1)}'`
echo "++++++++++++++++++++++++"
echo "Project name:"
echo "===$project_name==="
echo "++++++++++++++++++++++++"

#Select 5 newest file created today.
selfile_list=`ls -tl --time-style=long-iso $current_folder/*.$selfile_type|grep $(date -I)|awk '{print $8}' 2>/dev/null|head -n +5`
##echo selfile_list is $selfile_list
if [ -z "$selfile_list" ];then
	echo "No update package find,plases upload."
        exit
fi

#Check update flodeAr,judge by ./ROOT and ../webapps
if [ -d $current_folder/ROOT ] && [ -d ../webapps ]; then
        echo "Backup path:"
	echo "$current_folder/ROOT"
	echo "++++++++++++++++++++++++"
	echo -e "Input \"y\" start the backup:"
	read answer
	if [ "$answer" == "y" ] ;then
		echo `time_stamp` "Begin backup..."
		backup_time=`time_stamp`
		BackupFileName=ROOT-${backup_time}.tar.gz
		tar zcf "$BackupFileName" ./ROOT
		if [ $? == 0 ]; then
			echo `time_stamp` "Backup Success..."
			echo "++++++++++++++++++++++++"
			echo "Backup file:"
			echo "ROOT-${backup_time}.tar.gz"
			echo "++++++++++++++++++++++++"
		else
			echo `time_stamp` "Backup Failed,exit."
			exit
		fi
	else
		echo `time_stamp` "Input error,exit." 
		exit
	fi
else
        echo `time_stamp` "No update folder found,check the path,exit."
        exit
fi



echo "select update package,input number 1-5 [1 by defalut]:"
#Give filelist name to arr.
for selfile in $selfile_list
do
        selfile_arr[${i}]=$selfile
        ((++i))
done

#Display all arr(file list).
for selfile in ${selfile_arr[*]}
do
	echo [$x] $selfile
	x=$((1+$x))
done

#select menu
read select_num

case $select_num in
	""|1)
		select_num=1
		update_file=${selfile_arr[(($select_num - 1))]}
		;;
	[2-5])
		update_file=${selfile_arr[(($select_num - 1))]}
		echo  UpdateFile "$update_file" selected.
		;;
	*)
		echo choice error
		exit
		;;
esac
#Begin update project
##use variable
echo -e "Make sure:\n"
echo "ProjectName:$project_name"
echo "BackupFilePath:$current_folder/ROOT"
echo "BackupFileName:$BackupFileName"
echo "UpdateFileName:$update_file"
echo "DeleteConfigFile:"
echo 
echo -e "Input \"sure\" to Continue:"
read answer
if [ "$answer" == "sure" ] ;then
	echo `time_stamp` "Begin updating..."
	
	if [  -f $update_file ] ;then
		unzip -qo $update_file
		if [ $? == 0 ]; then
	                echo `time_stamp` "Update Success..."
	        else
	                echo `time_stamp` "Unzip Failed,check your update zip file.If the project does not work, restore the backup file ROOT${backup_time}.tar.gz"
	                exit
	        fi
	else
		echo `time_stamp` "update file not found,exit."
		exit
	fi
else
	echo `time_stamp` "Input error,exit." 
	exit
fi
##Kill project pid and start project
echo "++++++++++++++++++++++++++"
ps aux|grep $project_name/endorsed
project_pid=`ps aux|grep $project_name/endorsed|awk '{print $2}'`
echo -e "Select $project_name project's pid:\n$project_pid"
echo "+++++++++++++++++++++++++++"
