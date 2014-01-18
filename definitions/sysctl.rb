
define :sysctl, :compiletime => false  do

  params[:name] =~ /(\S+)\s*=\s*(.+)/
  key, value = $1, $2


  key_array = key.split(/\./)
#  hash = {}
  last = {}
#  key_array.inject(hash) { |h, k| last = h; h[k] = {}; h[k] }
  key_array.inject(node.default[:sysctl]) { |h, k| last = h; h[k] ||= {}; h[k] }
  last[key_array.pop] = value

  # set compiletime to true to force early setting of sysctl values before resources converge

  if params[:compiletime]
    re = /^#{key} = #{value.gsub(/\s+/, "\\s+")}$/
    execute "sysctl -w '#{key}=#{value}'" do
      action :nothing
      not_if { re.match(`sysctl #{key}`.chomp) }
    end.run_action(:run)
  end

  reload_command =
    case node['platform_family']
    when "debian"
      "/etc/init.d/procps start"
    else
      "/sbin/sysctl -p"
    end

  template_path =
    case node['platform_family']
    when "debian"
      "/etc/sysctl.d/68-chef-attributes.conf"
    else
      "/etc/sysctl.conf"
    end

  # only define the resources once (avoiding CHEF-3694)

  begin
    resources(:execute => "sysctl_definition_reload_etc_sysctl")
  rescue Chef::Exceptions::ResourceNotFound
    execute "sysctl_definition_reload_etc_sysctl" do
      command reload_command
      action :nothing
    end
  end

  t = begin
    resources(:template => "sysctl_template_file")
  rescue Chef::Exceptions::ResourceNotFound
    template "sysctl_template_file" do
      path template_path
      source "sysctl.conf.erb"
      cookbook "sk_sysctl"
      variables({
        :sysctl => {}
      })
      notifies :run, "execute[sysctl_definition_reload_etc_sysctl]", :immediately
    end
  end

  t.variables[:sysctl][key] = value

end

