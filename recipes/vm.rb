
# Do less swapping
sysctl "vm.swappiness = 10"
sysctl "vm.dirty_ratio = 60"
sysctl "vm.dirty_background_ratio = 2"

# overcommit like a mofo
sysctl "vm.overcommit_memory = 1"

# Keep at least 64MB of free RAM space available
sysctl "vm.min_free_kbytes = 65536"

