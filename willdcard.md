
```
curl https://get.acme.sh | sh
```
```
cd ~/.acme.sh/
```
```
./acme.sh  --issue -d *.${DOMAIN}  --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --accountemail me@example.ru --server letsencrypt
```
```
./acme.sh  --issue -d *.${DOMAIN} --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --debug --accountemail me@example.ru --renew
```
