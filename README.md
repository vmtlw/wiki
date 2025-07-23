# Разбор команд для установки и настройки acme.sh

## 1. Установка необходимых пакетов
emerge -av openssh app-admin/syslog-ng sys-process/cronie app-admin/logrotate socat
- Устанавливаемые пакеты:
  - openssh — сервер OpenSSH (для удаленного доступа по SSH).
  - syslog-ng — система логирования.
  - cronie — планировщик задач (альтернатива `cron`).
  - logrotate — утилита для управления лог-файлами (ротация логов).
  - socat — инструмент для перенаправления трафика (полезен при работе с сетевыми сервисами).

## 2. Добавление syslog-ng в автозапуск и запуск службы
rc-update add syslog-ng
openrc
- rc-update add syslog-ng — добавляет syslog-ng в автозапуск.
- openrc — включает присутсвующие в автозагрузке сервисы , если лежал, так же выключает отсутсвующие в отозагрузке сервисы, если подняты.

## 3. Установка acme.sh для автоматического управления SSL-сертификатами
git clone https://github.com/acmesh-official/acme.sh.git
cd ./acme.sh
- Клонирование репозитория acme.sh с GitHub.
- Переход в каталог acme.sh.

## 4. Установка acme.sh с заданными путями
./acme.sh --install --home /var/calculate/acme.sh --config-home /etc/acme.sh --cert-home /var/calculate/certs --accountemail support@calculate.ru
- --home /var/calculate/acme.sh — задает каталог установки.
- --config-home /etc/acme.sh — каталог конфигурации.
- --cert-home /var/calculate/certs — каталог хранения сертификатов.
- --accountemail support@calculate.ru — указывает email для учетной записи.

## 5. Добавление переменных окружения в .bashrc
cat /var/calculate/acme.sh/acme.sh.env >> ~/.bashrc
exec bash
- Добавляет переменные окружения acme.sh в .bashrc, чтобы они загружались при каждом запуске оболочки.
- exec bash — перезапускает текущую оболочку.

## 6. Регистрация аккаунта в Let's Encrypt
acme.sh --register-account -m support@calculate.ru
- Регистрирует учетную запись Let's Encrypt.

## 7. Установка Let’s Encrypt в качестве CA (Certification Authority)
acme.sh --set-default-ca  --server letsencrypt
- Устанавливает Let's Encrypt в качестве центра сертификации по умолчанию.

## 8. Настройка уведомлений в Telegram
TELEGRAM_BOT_APITOKEN=7881543101:AAEzn72pxS1TrwrwerwerFDTJwuBI TELEGRAM_BOT_CHATID="-1011111111111178343" acme.sh --set-notify --notify-hook telegram --notify-level 1
- TELEGRAM_BOT_APITOKEN — API-ключ Telegram-бота.
- TELEGRAM_BOT_CHATID — ID чата, куда будут отправляться уведомления.
- --set-notify --notify-hook telegram --notify-level 1 — включает уведомления в Telegram.

## 9. Добавление задания в cron для автоматического обновления сертификатов
acme.sh --install-cronjob
- Устанавливает cron-задание для автоматического обновления сертификатов.


## 9.1  Генерация сертификата
REGRU_API_Username='support@calculate.ru' REGRU_API_Password='апи_пароль' acme.sh --issue --dns dns_regru -d upload.calculate.ru
после этой команды логин и пароль от api больше придется указывать при гшенерации , они уже будут зафиксированы в /etc/acme.sh/account.conf


## 10. Установка SSL-сертификата для upload.calculate.ru
acme.sh --install-cert -d upload.calculate.ru --key-file /tmp/privkey.pem --fullchain-file /tmp/fullchain.pem
- -d upload.calculate.ru — указывает домен.
- --key-file /tmp/privkey.pem — конечный путь для закрытого ключа.
- --fullchain-file /tmp/fullchain.pem — конечный путь для полного цепочного сертификата.


### 10.1 А вот такой командой можно задеплоить сертификат на удаленный сервер
DEPLOY_SSH_USER="root" DEPLOY_SSH_SERVER="10.2.0.8" DEPLOY_SSH_KEYFILE="/etc/nginx/ssl/calculate-linux.org/privkey.pem" DEPLOY_SSH_FULLCHAIN="/etc/nginx/ssl/calculate-linux.org/fullchain.pem" DEPLOY_SSH_REMOTE_CMD="/etc/init.d/nginx restart" acme.sh --deploy -d *.calculate-linux.org --deploy-hook ssh

## 11. посмотреть что с моими сертификатами , кроме proms и acoola
acme.sh --list --listraw | grep  -v -e acoola -e proms | sed -e 's/|/\t/g' | column -t

## 12. обновить acme.sh до поcледней версии
