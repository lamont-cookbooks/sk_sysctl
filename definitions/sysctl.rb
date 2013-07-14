
define :sysctl, :compiletime => false  do

  params[:name] =~ /(\S+)\s*=\s*(.+)/
  key, value = $1, $2

  node.default['sysctl'] ||= {}
  node.default['sysctl'][key] = value

  # set compiletime to true to force early setting of sysctl values before resources converge

  if params[:compiletime]
    re = /^#{key} = #{value.gsub(/\s+/, "\\s+")}$/
    execute "sysctl -w '#{key}=#{value}'" do
      action :nothing
      not_if { re.match(`sysctl #{key}`.chomp) }
    end.run_action(:run)
  end

  # only define the resources once (avoiding CHEF-3694)

  begin
    resources(:execute => "sysctl_definition_reload_etc_sysctl")
  rescue Chef::Exceptions::ResourceNotFound
    execute "sysctl_definition_reload_etc_sysctl" do
      command "/sbin/sysctl -p"
      action :nothing
    end
  end

  t = begin
    resources(:template => "/etc/sysctl.conf")
  rescue Chef::Exceptions::ResourceNotFound
    template "/etc/sysctl.conf" do
      source "sysctl.conf.erb"
      cookbook "sysctl"
      variables({
        :sysctl => {}
      })
      notifies :run, "execute[sysctl_definition_reload_etc_sysctl]", :immediately
    end
  end

  t.variables[:sysctl][key] = value

end

