#!/bin/bash
#--------------------------  
#   Name:clean_backupfile
#   Type:function
#   Language:bash shell  
#   Date:2016-4-22  
#   Author:Jia Jianjun  
#   Email:jiajianjun(at)time2011.com  
#--------------------------
#Set clean file's type

file_type=gz

#Get old files list.
old_list=`ls -t $PWD/*.$file_type 2>/dev/null|tail -n +4`
echo $old_list

#Delete old files if have.
if [ -z "$old_list" ];then
        exit;
else
        rm -rf $old_list
fi
