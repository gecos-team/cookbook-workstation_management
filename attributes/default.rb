# Groups list definition
default["local_administrators"]["admin_groups"] = [ { 'name' => 'admin' } , { 'name' => 'adm' } ]
default["local_administrators"]["admin_users_to_add"] = []
default["local_administrators"]["admin_users_to_remove"] = [] 

default[:group_management][:extra_groups] = []
default[:group_management][:extra_users_to_add] = []
default[:group_management][:extra_users_to_remove] = [] 


default[:network_management][:ip_address] = ''
default[:network_management][:gateway] = ''
default[:network_management][:netmask] = ''
default[:network_management][:dns_servers] = []
default[:network_management][:conn_type] = ''
default[:network_management][:dhcp] = ''
