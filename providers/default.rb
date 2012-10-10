
action :set do
  new_resource.expr =~ /(\S+)\s*=\s*(.+)/
  key, value = $1, $2

  node.default['sysctl'] ||= {}
  node.default['sysctl'][key] = value
  re = /^#{key} = #{value.gsub(/\s+/, "\\s+")}$/
  execute "sysctl -w '#{key}=#{value}'" do
    not_if { re.match(`sysctl #{key}`.chomp) }
  end
  new_resource.notifies :create, new_resource.resources(:template => "/etc/sysctl.conf")
end

