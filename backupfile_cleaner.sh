#!/bin/bash
#--------------------------  
#   Name:clean_backupfile
#   Type:function
#   Language:bash shell  
#   Date:2016-4-22  
#--------------------------

#Set clean file's type
file_type=gz

#just save 3 newest files,default
file_num=4

#add options,file type and file want save number

#Get old files list.
old_list=`ls -t $PWD/*.$file_type 2>/dev/null|tail -n +$file_num`

#Delete old files if have.
if [ -z "$old_list" ];then
        exit;
else
        rm -rf $old_list
fi
