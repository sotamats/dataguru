# Build & Installation
```
$ git clone git@github.com:/sotamats/dataguru.git
$ cd dataguru
$ make
$ sudo make LOG_UPLOAD_PATH="/home/jiaqi/workspace/sotamats/shoebot/collect_data" install
```

### Set ID for Robot: BOT_ID

Default ID is "CVSCARM-A10-000000000"
```
$ sudo make BOT_ID="CVSCARM-A10-000000000" install
```

### Set log uploading path: LOG_UPLOAD_PATH

Default log path is `/tmp/dataguru/log`.
```
$ sudo make LOG_UPLOAD_PATH="your/log/path" install
```

# Start & Stop
```
$ sudo systemctl start dataguru
$ sudo systemctl stop dataguru
```

# Uninstall
```
$ cd dataguru
$ sudo make uninstall
```

# Notice

By default dataguru connects to 8022 port of `sotamats.hopto.org` from **outside** Shanghai Shoebot-lab. However if using **inside** Shoebot-lab, change `dataguru.conf.lua` to 22.

### Outside Shanghai Lab

dataguru.conf.lua
```
ssh = {
  port = 8022
}
```

### Inside Shanghai Lab

dataguru.conf.lua
```
ssh = {
  port = 22
}
```
