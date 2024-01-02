#disable disk:

`udisksctl power-off -b /dev/sdb`

#else 

`hdparm -s 0 /dev/sda`


