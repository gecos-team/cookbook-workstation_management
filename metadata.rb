name              "workstation_management"
maintainer        "Alfonso de Cala"
maintainer_email  "alfonso.cala@juntadeandalucia.es"
license           "Apache 2.0"
description       "Cookbook providing recipes for GECOS workstations administration"
version           "0.1.2"


provides          "workstation_management::local_administrators"
recipe            "workstation_management::local_administrators", "Add or Remove users from given administrators groups lists"

provides          "workstation_management::local_users"
recipe            "workstation_management::local_users", "Add/Remove local users and change their passwords"

provides          "workstation_management::extra_groups"
recipe            "workstation_management::extra_groups", "Add or Remove users from given groups lists"

provides            "workstation_management::file_copy"
recipe            "workstation_management::file_copy", "Copy remote files to the Chef node."

provides            "workstation_management::file_delete"
recipe            "workstation_management::file_delete", "Remove local files of the Chef node."

provides            "workstation_management::network_management"
recipe            "workstation_management::network_management", "Set network configuration"

provides            "workstation_management::ntp_sync"
recipe            "workstation_management::ntp_sync", "Set ntp synchronization"


%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'file_copy/file_copy',
  :display_name => "Create Files",
  :description  => "List of files",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'workstation_management::file_copy' ]
  
attribute 'file_copy/file_copy/file_url',
  :display_name => "File URL",
  :description  => "URL of the original file",
  :type         => "string",
  :required     => "required",
  :validation   => "url",
  :order        => "0",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/path_client',
  :display_name => "Destination path",
  :description  => "Local path and filename in the workstation",
  :type         => "string",
  :required     => "required",
  :validation   => "abspath",
  :order        => "1",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/user',
  :display_name => "Owner user",
  :description  => "File's owner username",
  :type         => "string",
  :required     => "required",
  :wizard       => "users",
  :order        => "2",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/group',
  :display_name => "Owner group",
  :description  => "File's owner group",
  :type         => "string",
  :required     => "required",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "3",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/mode',
  :display_name => "Mode",
  :description  => "Mode of file (example: 0775)",
  :type         => "string",
  :required     => "required",
  :validation   => "modefile",
  :order        => "4",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/overwrite',
  :display_name => "Overwrite",
  :description  => "Copy this file even if it already existed",
  :type         => "string",
  :required     => "required",
  :choice       => [ "true", "false" ],
  :order        => "5",
  :recipes      => [ 'workstation_management::file_copy' ]

attribute 'file_copy/file_copy/comments',
  :display_name => "Comments",
  :description  => "A reason to copy this file",
  :type         => "string",
  :order        => "6",
  :recipes      => [ 'workstation_management::file_copy' ]


attribute 'file_delete/file_delete',
  :display_name => "Remove Files",
  :description  => "List of files to delete",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'workstation_management::file_delete' ]

attribute 'file_delete/file_delete/file_path',
  :display_name => "File Path",
  :description  => "Full path of  the file to delete",
  :type         => "string",
  :required     => "required",
  :validation   => "abspath",
  :order        => "0",
  :recipes      => [ 'workstation_management::file_delete' ]

attribute 'file_copy/file_delete/comments',
  :display_name => "Comments",
  :description  => "A reason to delete this file",
  :type         => "string",
  :order        => "1",
  :recipes      => [ 'workstation_management::file_delete' ]


attribute 'local_users/local_users',
  :display_name => "Local users",
  :description  => "A list of users with local validation only",
  :type         => "array",
  :required     => "required",
  :recipes      => ['workstation_management::local_users']

attribute 'local_users/local_users/username',
  :display_name => "User Name",
  :description  => "Local user short name",
  :type         => "string",
  :required     => "required",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "0",
  :recipes      => [ 'workstation_management::local_users' ]

attribute 'local_users/local_users/password',
  :display_name => "Password",
  :description  => "Secret key for this user",
  :type         => "string",
  :required     => "required",
  :order        => "1",
  :recipes      => [ 'workstation_management::local_users' ]

attribute 'local_users/local_users/action',
  :display_name => "Action",
  :description  => "Create (and modify) or delete this user",
  :type         => "string",
  :choice       => [ "create", "delete" ],
  :required     => "required",
  :order        => "2",
  :recipes      => [ 'workstation_management::local_users' ]

attribute 'local_administrators/admin_groups',
  :display_name => "Administrator groups",
  :description  => "List of groups for administration purposes that users will be added or removed to",
  :type         => "array",
  :default      => [ { 'name' => 'admin' } , { 'name' => 'adm' } ],
  :recipes      => ['workstation_management::local_administrators']

attribute 'local_administrators/admin_groups/name',
  :display_name => "Group name",
  :description  => "Administration purpose group's name",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "0",
  :recipes      => ['workstation_management::local_administrators']

attribute 'local_administrators/admin_users_to_add',
  :display_name => "Users to add to admin groups",
  :description  => "List of users that will be added to admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::local_administrators']

attribute 'local_administrators/admin_users_to_add/user',
  :display_name => "User to add to admin groups",
  :description  => "This user will have admin privileges when logs into the workstation",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "1",
  :recipes      => ['workstation_management::local_administrators']

attribute 'local_administrators/admin_users_to_remove',
  :display_name => "Users to be removed from admin groups",
  :description  => "List of users that will be removed from admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::local_administrators']

attribute 'local_administrators/admin_users_to_remove/user',
  :display_name => "User to remove from admin groups",
  :description  => "User to remove from admin groups",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "2",
  :recipes      => ['workstation_management::local_administrators']

attribute 'group_management/extra_groups',
  :display_name => "Extra groups",
  :description  => "List of extra groups that users will be added or removed to",
  :type         => "array",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_groups/name',
  :display_name => "Group name",
  :description  => "Group name",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "0",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_users_to_add',
  :display_name => "Users to add to extra groups",
  :description  => "List of users that will be added to extra groups",
  :type         => "array",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_users_to_add/user',
  :display_name => "User to add to extra groups",
  :description  => "User will be added to extra groups",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "1",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_users_to_remove',
  :display_name => "Users to be removed from extra groups",
  :description  => "List of users that will be removed from extra groups",
  :type         => "array",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_users_to_remove/user',
  :display_name => "User to remove from extra groups",
  :description  => "User to remove from extra groups",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :order        => "2",
  :recipes      => ['workstation_management::extra_groups']

#attribute 'group_management/base_users_to_add',
#  :display_name => "Users to add to base groups",
#  :description  => "List of users that will be added to base groups",
#  :type         => "array",
#  :recipes      => ['workstation_management::group_management']
#
#attribute 'group_management/base_users_to_add/user',
#  :display_name => "User to add to base groups",
#  :description  => "User to add to base groups",
#  :type         => "string",
#  :validation   => "alphanumericwithdots",
#  :group        => "2",
#  :recipes      => ['workstation_management::group_management']
#
#attribute 'group_management/base_users_to_remove',
#  :display_name => "Users to remove from base groups",
#  :description  => "List of users that will be remove from base groups",
#  :type         => "array",
#  :recipes      => ['workstation_management::group_management']
#
#attribute 'group_management/base_users_to_remove/user',
#  :display_name => "User to remove from base groups",
#  :description  => "User to remove from base groups",
#  :type         => "string",
#  :validation   => "alphanumericwithdots",
#  :order        => "3",
#  :recipes      => ['workstation_management::group_management']

attribute 'network_management/conn_type',
  :display_name => "Connection type",
  :description  => "Set connection type",
  :type         => "string",
  :choice       => [ "wired" ], #, "wireless" ],
  :required     => "required",
  :default      => "wired",
  :order        => "0",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/dhcp',
  :display_name => "DHCP",
  :description  => "Set if network uses DHCP or not",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :required     => "required",
  :dependent    => [ { "field" => "network_management/ip_address", "validator" => "isfalse" } , { "field" => "network_management/gateway", "validator" => "isfalse" } , { "field" => "network_management/netmask", "validator" => "isfalse" } , { "field" => "network_management/dns_servers/ip", "validator" => "isfalse" } ],
  :default      => "true",
  :order        => "1",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/ip_address',
  :display_name => "IP",
  :description  => "Set interface IP address",
  :type         => "string",
  :validation   => "ip",
  :required     => "required",
  :default      => "",
  :order        => "2",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/gateway',
  :display_name => "Gateway",
  :description  => "Set interface gateway address",
  :type         => "string",
  :validation   => "ip",
  :required     => "required",
  :default      => "",
  :order        => "3",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/netmask',
  :display_name => "Netmask",
  :description  => "Set interface netmask address",
  :type         => "string",
  :validation   => "ip",
  :required     => "required",
  :default      => "",
  :order        => "4",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/dns_servers',
  :display_name => "DNS Servers",
  :description  => "",
  :type         => "array",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'network_management/dns_servers/ip',
  :display_name => "DNS Server IP",
  :description  => "DNS server's IPv4 address",
  :type         => "string",
  :validation   => "ip",
  :default      => "",
  :order        => "5",
  :recipes      => [ 'workstation_management::network_management' ]

attribute 'ntp_sync/server',
  :display_name => "NTP Server hostname/IP",
  :description  => "Sets the ntp server that will be used for time synchronization",
  :type         => "string",
  :validation   => "alphanumericwithdotsdashes",
  :required     => "required",
  :default      => "0.es.pool.ntp.org",
  :order        => "0",
  :recipes      => [ 'workstation_management::ntp_sync' ]

