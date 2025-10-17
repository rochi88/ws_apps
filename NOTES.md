# NOTES

## To increase the Linux file watcher limit (inotify max_user_watches)
on Ubuntu 24.04, follow these steps:

1. Check the current limit
```sh
cat /proc/sys/fs/inotify/max_user_watches
```
2. Create a new configuration file for sysctl or append to an existing one. A common practice is to create a new file in `/etc/sysctl.d/`. For example, to set the limit to 524288
```sh
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/99-inotify.conf
```
3.  Apply the changes
```sh
sudo sysctl --system
```
4. Verify the new limit
```sh
cat /proc/sys/fs/inotify/max_user_watches
```