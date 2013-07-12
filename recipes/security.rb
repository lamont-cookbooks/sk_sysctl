
# no routing on typical servers
sysctl "net.ipv4.ip_forward = 0"

# no source routing or redirects
sysctl "net.ipv4.conf.default.rp_filter = 1"
sysctl "net.ipv4.conf.all.rp_filter = 1"
sysctl "net.ipv4.conf.default.secure_redirects = 0"
sysctl "net.ipv4.conf.all.secure_redirects = 0"
sysctl "net.ipv4.conf.default.send_redirects = 0"
sysctl "net.ipv4.conf.all.send_redirects = 0"
sysctl "net.ipv4.conf.default.accept_source_route = 0"
sysctl "net.ipv4.conf.all.accept_source_route = 0"
sysctl "net.ipv4.conf.default.accept_redirects = 0"
sysctl "net.ipv4.conf.all.accept_redirects = 0"

if File.exists?("/proc/sys/net/ipv6")
  # IPv6-specific section
  sysctl "net.ipv6.conf.all.forwarding = 0"
  sysctl "net.ipv6.conf.default.accept_redirects = 0"
  sysctl "net.ipv6.conf.all.accept_redirects = 0"
  sysctl "net.ipv6.conf.default.accept_source_route = 0"
  sysctl "net.ipv6.conf.all.accept_source_route = 0"
  sysctl "net.ipv6.conf.default.router_solicitations = 0"
  sysctl "net.ipv6.conf.all.router_solicitations = 0"
  sysctl "net.ipv6.conf.default.accept_ra_rtr_pref = 0"
  sysctl "net.ipv6.conf.all.accept_ra_rtr_pref = 0"
  sysctl "net.ipv6.conf.default.accept_ra_pinfo = 0"
  sysctl "net.ipv6.conf.all.accept_ra_pinfo = 0"
  sysctl "net.ipv6.conf.default.accept_ra_defrtr = 0"
  sysctl "net.ipv6.conf.all.accept_ra_defrtr = 0"
  sysctl "net.ipv6.conf.default.autoconf = 0"
  sysctl "net.ipv6.conf.all.autoconf = 0"
  sysctl "net.ipv6.conf.default.dad_transmits = 0"
  sysctl "net.ipv6.conf.all.dad_transmits = 0"
  sysctl "net.ipv6.conf.default.max_addresses = 1"
  sysctl "net.ipv6.conf.all.max_addresses = 1"
end

# synflood settings
sysctl "net.ipv4.tcp_syncookies = 1"
sysctl "net.ipv4.tcp_max_syn_backlog = 4096"
sysctl "net.ipv4.tcp_synack_retries = 2"
sysctl "net.ipv4.tcp_syn_retries = 5"

# don't ignore directed pings
sysctl "net.ipv4.icmp_echo_ignore_all = 0"

# ignore broadcast ping
sysctl "net.ipv4.icmp_echo_ignore_broadcasts = 1"

# Enable bad error message Protection
sysctl "net.ipv4.icmp_ignore_bogus_error_responses = 1"

# log martians
sysctl "net.ipv4.conf.all.log_martians = 1"

# kernel hardening
#sysctl "kernel.exec-shield = 1"
sysctl "kernel.randomize_va_space = 1"

# The contents of /proc/<pid>/maps and smaps files are only visible to
# readers that are allowed to ptrace() the process
#sysctl "kernel.maps_protect = 1"

# specifies the minimum virtual address that a process is allowed to mmap
sysctl "vm.mmap_min_addr = 4096"

