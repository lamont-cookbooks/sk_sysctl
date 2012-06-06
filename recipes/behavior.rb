
sysctl "kernel.sysrq = 1"

sysctl "kernel.core_uses_pid = 1"

sysctl "fs.file-max = 1000000"

sysctl "kernel.pid_max = 65535"

sysctl "net.ipv4.ip_local_port_range = 1024 65535"

# Auto-reboot linux 30 seconds after a kernel panic
sysctl "kernel.panic = 30"
sysctl "kernel.panic_on_oops = 30"
