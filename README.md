# Pluggable Authentication Modules (PAM, подключаемые модули аутентификации) 

Домашнее задание

1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни


Для того чтобы запретить всем кроме группы root локалынй логин и вход по ssh 
Необходино добавить в конфигурационны файл 

/etc/security/time.conf

login;tty* & !ttyp*;!root;Wd0000-2400
sshd;tty* & !ttyp*;!root;Wd0000-2400

включаем модуль pam_time.so

sudo sed -i '5i\account required pam_time.so' /etc/pam.d/login
sudo sed -i '4i\account required pam_time.so' /etc/pam.d/sshd 

