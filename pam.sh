#!/usr/bin/env bash

# Проверка даты на принадлежность к нерабочему дню, согласно официальным указам и распоряжениям.
# Подробнее: https://isdayoff.ru/desc/
TODAY=$(curl https://isdayoff.ru/$(date +%Y%m%d)?ru=CC)
# Проверяем принадлежность пользователя к группе admin
GROUP=$(groups $PAM_USER | grep -c admin)

if [[ $TODAY -ne 1 ]]; then  # Сравниваем значекние переменной. Если не выходной или праздник,возвращяем 0
      exit 0
else
  if [[ $GROUP -eq 1 ]]; then # Проверяем группу. Если группа admin возвращаем 0 если нет то возвращаем ошибку. 
      exit 0
    else
      exit 1
  fi
fi

