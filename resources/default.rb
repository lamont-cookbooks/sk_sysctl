actions :set

attribute :expr, :kind_of => String, :name_attribute => true
attribute :override, :kind_of => [TrueClass, FalseClass], :default => false

def initialize(*args)
  super
  @action = :set
  node['sysctl'] = {}
end
