# Pluggable Authentication Modules (PAM, подключаемые модули аутентификации) 

Домашнее задание

Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни

1. Запретить вход в выходные.

Для того чтобы запретить всем кроме группы admin локальный логин и вход по ssh 
Необходино добавить в конфигурационны файл 

/etc/security/time.conf

login;tty* & !ttyp*;!admin;Wd0000-2400

sshd;tty* & !ttyp*;!admin;Wd0000-2400

И добавить модуль проверки времени 

sudo sed -i '5i\account required pam_time.so' /etc/pam.d/login

sudo sed -i '4i\account required pam_time.so' /etc/pam.d/sshd 

2. Запретить вход в праздники.

Штатными средствами решить этот вопрос не представляется возможным. По этому прибегнул к сайту https://isdayoff.ru.

Загружаем скрипт в /etc

Добавляем модуль проверки кастомного скрипта 

sed -i "7i account     required       pam_exec.so    /etc/pam.sh" /etc/pam.d/sshd

Теперь в выходные и праздники будет пускать только группу admin


