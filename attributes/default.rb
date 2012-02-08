# Groups list definition
default[:group_management][:admin_groups]['0'][:group] = 'admin'
default[:group_management][:admin_groups]['1'][:group] = 'adm'
default[:group_management][:admin_users_to_add] = []
default[:group_management][:admin_users_to_remove] = [] 
default[:group_management][:base_groups]['0'][:group] = 'dialout'
default[:group_management][:base_groups]['1'][:group] = 'fax'
default[:group_management][:base_groups]['2'][:group] = 'cdrom'
default[:group_management][:base_groups]['3'][:group] = 'floppy'
default[:group_management][:base_groups]['4'][:group] = 'tape'
default[:group_management][:base_groups]['5'][:group] = 'audio'
default[:group_management][:base_groups]['6'][:group] = 'dip'
default[:group_management][:base_groups]['7'][:group] = 'video'
default[:group_management][:base_groups]['8'][:group] = 'plugdev'
default[:group_management][:base_groups]['9'][:group] = 'fuse'
default[:group_management][:base_groups]['10'][:group] = 'sambashare'
default[:group_management][:base_users_to_add] = []
default[:group_management][:base_users_to_remove] = []

default[:network_management][:ip_address] = ''
default[:network_management][:gateway] = ''
default[:network_management][:netmask] = ''
default[:network_management][:dns_servers] = []
default[:network_management][:conn_type] = ''
default[:network_management][:dhcp] = ''
