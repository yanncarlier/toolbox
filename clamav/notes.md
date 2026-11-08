


```
systemctl status clamav-daemon clamav-freshclam   # are the services running?
sudo tail -n 50 /var/log/clamav/clamav.log        # any scan activity?
sudo tail -n 20 /var/log/clamav/freshclam.log     # are definitions updating?
apt-cache rdepends --installed clamav-daemon      # what other packages depend on it?
```

### Update

```
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl start clamav-freshclam
```

### Why it might not be updating

```bash
systemctl status clamav-freshclam
sudo tail -n 30 /var/log/clamav/freshclam.log
```



### If you want to use it

Run a manual scan of your home directory:

```bash
clamscan -r --infected ~/Desktop/
```

Or use the daemon, which is faster since the signatures are already loaded:

```bash
clamdscan --multiscan --fdpass ~
```

For real-time scanning you’d need to configure `clamonacc` (on-access scanning) in `/etc/clamav/clamd.conf`. If you don’t need any of this, you can remove it with 

```
sudo apt remove clamav clamav-daemon clamav-freshclam clamav-base clamdscan
```

