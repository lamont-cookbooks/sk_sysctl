
# Controls the maximum size of a message, in bytes
sysctl "kernel.msgmnb = 65536"

# Controls the default maxmimum size of a mesage queue
sysctl "kernel.msgmax = 65536"

# Set maximum amount of memory allocated to shm to 256MB
sysctl "kernel.shmmax = 268435456"
sysctl "kernel.shmall = 268435456"

