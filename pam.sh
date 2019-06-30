#!/usr/bin/env bash
#DATE=$(date +%y%m%d)
TODAY=$(curl https://isdayoff.ru/$(date +%Y%m%d)?ru=CC)
GROUP=$(groups $PAM_USER | grep -c admin)

if [[ $GROUP -eq 1 ]]; then    
  if [[ $TODAY -eq 0 ]]; then 
      exit 1
  else
      exit 0
  fi
 fi
