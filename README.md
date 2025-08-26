# Setup notes:

## enable ipv6 in docker

1. Edit `/etc/docker/daemon.json`

   ```json
   {
     "ipv6": true,
     "fixed-cidr-v6": "200x:xxxx:1::/64"
   }
   ```

1. restart docker
   ```console
   systemctl reload docker
   ```
1. run asterisk

   ```console
   docker run --rm --name asterisk -d rep.tnstlab.com:31320/docker-asterisk:1
   ```
## config files to mount to docker container

1. main.cf (postfix) mounted at /etc/postfix/main.cf
2. directory of asterisk config files mounted at /etc/asterisk/
