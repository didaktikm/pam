#!/usr/bin/env bash
DATE=$(date +%y%m%d)
TODAY=$(curl https://isdayoff.ru/"$DATE"?ru=CC)
GROUP=$(groups $PAM_USER)

if [[ $GROUP = "admin" ]]; then    
    exit 0
fi

if [[ $TODAY -eq 1 ]]; then  
    exit 1
  else
    exit 0
fi