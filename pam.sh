#!/usr/bin/env bash
DATE=$(date +%y%m%d)
TODAY=$(curl https://isdayoff.ru/"$DATE"?ru=CC)
GROUP=$(groups $PAM_USER)

if [[ $TODAY -eq 0 ]]; then
  if [[ $GROUP = "admin" ]]; then    
    exit 0
  else
    exit 1
  fi
fi