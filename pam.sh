#!/usr/bin/env bash

# Проверяем принадлежность пользователя к группе admin
GROUP=$(groups $PAM_USER | grep -c admin)
# Проверка даты на принадлежность к нерабочему дню, согласно официальным указам и распоряжениям.
# Подробнее: https://isdayoff.ru/desc/
TODAY=$(curl https://isdayoff.ru/"$(date +%Y%m%d)"?ru=CC)
if [[ "$?" -eq 0 ]]; then # Если вернулась ошибка переходим к локальной роверке из файла holidays.
  if [[ $TODAY -ne 1 ]]; then  # Сравниваем значение переменной. Если не выходной или праздник,возвращяем 0
      exit 0
  else
    if [[ $GROUP -eq 1 ]]; then # Проверяем группу. Если группа admin возвращаем 0 если нет то возвращаем ошибку. 
       exit 0
      else
        exit 1
    fi
  fi
else
    if [[ $(date +%u) -gt 5 ]]; then # Проверяем что сегодня выходной.
        exit 1
    elif [[ $(grep -q `date +%d.%m` /etc/holidays) ]]; then # Проверяем не праздник ли из файла
        if [[ $GROUP -eq 1 ]]; then  
            exit 1
        else
            exit 0
        fi    
    fi
fi

