#!/bin/bash
#Проверим, есть ли пользователь в группе admin
if getent group admin | grep -qw "$PAM_USER"; then
        #Если пользователь входит в группу admin, то он может подключиться
        exit 0
else
        #Если день недели суббота или воскресенье
        if [ $(date +%a) = "Sat" ] || [ $(date +%a) = "Sun" ]; then
            #не сможет подключиться
            exit 1
        else 
            exit 0
        fi
fi
