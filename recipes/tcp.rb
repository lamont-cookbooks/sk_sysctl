
# bigass windows
sysctl "net.core.wmem_max=12582912"
sysctl "net.core.rmem_max=12582912"
sysctl "net.ipv4.tcp_rmem=10240 12582912 12582912"
sysctl "net.ipv4.tcp_wmem=10240 12582912 12582912"

# performance
sysctl "net.ipv4.tcp_window_scaling = 1"
sysctl "net.ipv4.tcp_timestamps = 1"
sysctl "net.ipv4.tcp_sack = 1"
sysctl "net.ipv4.tcp_dsack = 1"
sysctl "net.ipv4.tcp_fack = 1"

sysctl "net.core.netdev_max_backlog = 4096"

