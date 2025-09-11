cat /etc/ipsec.conf 
config setup
    charondebug="ike 2, knl 2, cfg 2, net 2"

conn ikev2-psk
    keyexchange=ikev2
    type=tunnel
    auto=add
    dpdaction=clear
    dpddelay=30s
    rekey=no
    fragmentation=yes
    forceencaps=yes


    # Локальная сторона
    left=%any
    leftid=89.179.122.11
    leftauth=psk
    leftsubnet=0.0.0.0/0

    # Удалённая сторона (клиент)
    right=%any
    rightid=%any
    rightauth=psk
    rightsourceip=10.10.10.0/24
    ike=chacha20poly1305-sha512-curve25519-prfsha512,aes256gcm16-sha384-prfsha384-ecp384,aes256-sha1-modp1024,aes128-sha1-modp1024,3des-sha1-modp1024!
    esp=chacha20poly1305-sha512,aes256gcm16-ecp384,aes256-sha256,aes256-sha1,3des-sha1!


cat /etc/ipsec.secrets 
: PSK "password-storg-line"

tree -d /etc/ipsec.d/
/etc/ipsec.d/
├── aacerts
├── acerts
├── cacerts
├── certs
├── crls
├── ocspcerts
├── policies
├── private
└── reqs

  501  iptables -L
  502  iptables -F
  503  iptables -X
  504  iptables -Z
  505  iptables -t nat -F
  506  iptables -t nat -X
  507  iptables -t nat -Z
  508  iptables -t mangle -F
  509  iptables -t mangle -X
  510  iptables -t mangle -Z
  516  systemctl restart docker
  511  iptables -A FORWARD -s 10.10.10.0/24 -o br0 -j ACCEPT
  512  iptables -A FORWARD -d 10.10.10.0/24 -i br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
  513  iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o br0 -j MASQUERADE
