settings {
    logfile = "/var/log/dataguru/dataguru.log",
    statusFile = "/var/log/dataguru/dataguru-status.log",
    statusInterval = 20,
    nodaemon = true
}

sync {
   default.rsyncssh,
   source="/home/dataguru/log",
   host="sotamats",
   excludeFrom="/etc/dataguru/dataguru.exclude",
   targetdir="/home/dataguru/from_outside/BOT_ID/log",
   delete = false,
   delay = 10,
   rsync = {
     archive = true,
     compress = true,
     whole_file = false,
     verbose = false
   },
   ssh = {
     identityFile = "~/.ssh/id_rsa_dataguru",
     port = 22
   }
}
