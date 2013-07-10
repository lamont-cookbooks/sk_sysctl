
define :sysctl, :immediately => false  do

  params[:name] =~ /(\S+)\s*=\s*(.+)/
  key, value = $1, $2

  node.default['sysctl'] ||= {}
  node.default['sysctl'][key] = value

  execute "/sbin/sysctl -p" do
    action :nothing
  end

  t = nil
  begin
    t = resources(:template => "/etc/sysctl.conf")
  rescue Chef::Exceptions::ResourceNotFound
    t = template "/etc/sysctl.conf" do
      source "sysctl.conf.erb"
      cookbook "sysctl"
      notifies :run, "execute[/sbin/sysctl -p]", :immediately
    end
  end

end

