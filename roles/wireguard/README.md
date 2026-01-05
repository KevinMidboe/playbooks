# wireguard

> NB! This is still pretty stupid - use with caution.

inside lxc, need to add to proxmox config:

```yaml
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
```

## setup

To configure forwarding, open the `/etc/sysctl.conf` and uncomment the line:

```bash
net.ipv4.ip_forward=1
sysctl -p
```

```bash
cd /etc/wireguard
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
```

```bash
wg genkey | tee client_privatekey | wg pubkey > client_publickey
```

add server config

```ini
[Interface]
Address = 10.7.0.1/24
PrivateKey = 
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
```

Set permissions

```bash
sudo chown -R root:root /etc/wireguard/
sudo chmod -R og-rwx /etc/wireguard/*
```

Enable service

```bash
sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
```

Add peer configuration

```bash
wg genkey | tee client_privatekey | wg pubkey > client_publickey
```

add file `/home/kevin/CLIENT_NAME.conf`. If want full tunnel change to `AllowedIPs = 0.0.0.0/0, ::/0`

```ini
[Interface]
Address = 10.7.0.2/32
DNS = 10.0.0.72, 1.1.1.1, 1.1.0.0
PrivateKey = 

[Peer]
PublicKey = 
# PresharedKey =
AllowedIPs = 10.7.0.0/24, 10.0.0.0/24
Endpoint = 
PersistentKeepalive = 25
```

also add to server config

```ini
# BEGIN_PEER CLIENT_NAME
[Peer]
PublicKey = 
# PresharedKey =
AllowedIPs = 10.7.0.2/32
# END_PEER CLIENT_NAME
```

remove generated keys

```bash
rm client_privatekey client_publickey
```

generate qr

```bash
qrencode -t UTF8 < CLIENT_NAME.conf
```
