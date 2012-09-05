
# only swap when forced to
sysctl "vm.swappiness = 0"
# when a file buffers hit 10% of total mem flush them (more aggressive than default)
sysctl "vm.dirty_ratio = 10"
# when 2% of memory is dirty run pdflush (more aggressive, more flushes)
sysctl "vm.dirty_background_ratio = 2"

# overcommit like a mofo
sysctl "vm.overcommit_memory = 1"

# Keep at least 64MB of free RAM space available
#sysctl "vm.min_free_kbytes = 65536"

