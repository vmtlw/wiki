# Whith Acme.sh script:

## please download script:

```
curl https://get.acme.sh | sh ;  cd ~/.acme.sh/
```

## Gen you script!:

```
./acme.sh  --issue -d *.${DOMAIN}  --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --accountemail myname@mydomain.com --server letsencrypt
```
## please, add TXT records in you dns provider and check:
```
nslookup _acme-challenge.${DOMAIN} 8.8.8.8
```

## if all ok, run this:
 
```
./acme.sh  --issue -d *.${DOMAIN} --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --debug --accountemail me@example.ru --renew
```
## ACME Client Implementations: https://letsencrypt.org/docs/client-options/#acme-v2-compatible-clients
