для сборки самбы из исходников доустановите в CLS необходимые пакеты : 
`emerge -av pkgconf sys-libs/talloc dev-db/lmdb sys-apps/dbus dev-python/markdown net-libs/rpcsvc-proto`

Далее скачайте исходный код самбы и распакуйте:
`wget https://download.samba.org/pub/samba/samba-latest.tar.gz`
`tar -xf samba-*;`

Перейдите в папку Samba-* командой:
cd samba-*;

`./configure --with-system-mitkrb5 --with-experimental-mit-ad-dc
make
make install`

В версии 4.17 и выше можно сконфигурировать сервер в интерактивном режиме:
`samba-tool domain provision --use-rfc2307 --interactive`
