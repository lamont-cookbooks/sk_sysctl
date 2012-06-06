
# override the default setting that turns this off
sysctl "net.ipv4.ip_forward = 1" do
  override true
end

