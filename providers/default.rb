
action :set do
  new_resource.expr =~ /(\S+)\s*=\s*(\S+)/
  key, value = $1, $2

  node.default['sysctl'] ||= {}
  node.default['sysctl'][key] = value
  execute "sysctl -w #{key}=#{value}" do
    not_if { `sysctl #{key}`.chomp == "#{key} = #{value}" }
  end
  new_resource.notifies :create, new_resource.resources(:template => "/etc/sysctl.conf")
end

