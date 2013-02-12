
action :set do
  new_resource.expr =~ /(\S+)\s*=\s*(.+)/
  key, value = $1, $2

  node.default['sysctl'] ||= {}
  node.default['sysctl'][key] = value
  re = /^#{key} = #{value.gsub(/\s+/, "\\s+")}$/
  unless re.match(`sysctl #{key}`.chomp)
    if new_resource.immediately
      execute "sysctl -w '#{key}=#{value}'"
    end
    new_resource.notifies :create, new_resource.resources(:template => "/etc/sysctl.conf")
  end
end

