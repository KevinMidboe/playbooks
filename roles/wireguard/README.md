# wireguard

## setup

If you don't have a tunnel network device configured, run using:

```bash
sudo mkdir /dev/net/tun
sudo mknod /dev/net/tun c 10 200
```

To configure forwarding, open the `/etc/sysctl.conf` and uncomment the line:

```bash
net.ipv4.ip_forward=1
sysctl -p
```

## lxc host configuration

In the host config for the lxc running wg we need to add the following:

```yaml
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
```
