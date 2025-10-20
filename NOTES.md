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

## `.bashec` extra paths as example
```sh
# Java
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export PATH="$PATH:$JAVA_HOME/bin"

# Android
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Flutter
export PATH="$PATH:$HOME/flutter/bin"

# Pub Cache
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Puro
export PATH="$PATH:$HOME/.puro/bin" # Added by Puro
export PATH="$PATH:$HOME/.puro/shared/pub_cache/bin" # Added by Puro
export PATH="$PATH:$HOME/.puro/envs/default/flutter/bin" # Added by Puro
export PURO_ROOT="/home/octopus/.puro" # Added by Puro

# Golang
export PATH=$PATH:/usr/local/go/bin

# Rust
. "$HOME/.cargo/env"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```