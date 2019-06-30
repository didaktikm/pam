#!/usr/bin/env bash
#DATE=$(date +%y%m%d)
TODAY=$(curl https://isdayoff.ru/$(date +%Y%m%d)?ru=CC)
GROUP=$(groups $PAM_USER | grep -c admin)

if [[ $GROUP -eq 1 ]] && [[ $TODAY -eq 1 ]]; then    
      exit 0
  else
      exit 1
fi
