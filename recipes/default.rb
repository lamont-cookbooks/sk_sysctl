
include_recipe "sysctl::vm"
include_recipe "sysctl::tcp"
include_recipe "sysctl::shm"
include_recipe "sysctl::behavior"
include_recipe "sysctl::security"

template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
  action :nothing
  notifies :run, "execute[/sbin/sysctl -p]", :immediately
end

execute "/sbin/sysctl -p" do
  action :nothing
end
