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
   :/$ systemctl reload docker
   ```
1. create docker Network

   ```console
   :/$ docker network create
   ```
