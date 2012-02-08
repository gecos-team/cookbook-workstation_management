name              "workstation_management"
maintainer        "Roberto C. Morano"
maintainer_email  "rcmorano@emergya.com"
license           "Apache 2.0"
description       "Cookbook that provides recipes for GECOS workstations administration"
version           "0.1.1"


provides          "workstation_management::admin_groups"
recipe            "workstation_management::admin_groups", "Add or Remove users from given administrators groups lists"

provides          "workstation_management::extra_groups"
recipe            "workstation_management::extra_groups", "Add or Remove users from given groups lists"



provides            "workstation_management::file_copy"
provides            "workstation_management::file_delete"
recipe            "workstation_management::file_copy", "Copy remote files to the Chef node."
recipe            "workstation_management::file_delete", "Remove local files of the Chef node."

provides            "workstation_management::network_management"
recipe            "workstation_management::network_management", "Set network configuration"

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
  :description  => "Destination path in the workstation",
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
  :wizard       => "groups",
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


attribute 'group_management/admin_groups',
  :display_name => "Administrator groups",
  :description  => "List of groups for administration purposes that users will be added or removed to",
  :type         => "array",
  :default      => [ { 'name' => 'admin' } , { 'name' => 'adm' } ],
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/admin_groups/name',
  :display_name => "Group name",
  :description  => "Administration purpose group's name",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "0",
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/admin_users_to_add',
  :display_name => "Users to add to admin groups",
  :description  => "List of users that will be added to admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/admin_users_to_add/user',
  :display_name => "User to add to admin groups",
  :description  => "User will be added to admin groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "1",
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/admin_users_to_remove',
  :display_name => "Users to be removed from admin groups",
  :description  => "List of users that will be removed from admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/admin_users_to_remove/user',
  :display_name => "User to remove from admin groups",
  :description  => "User to remove from admin groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "2",
  :recipes      => ['workstation_management::admin_groups']

attribute 'group_management/extra_groups',
  :display_name => "Extra groups",
  :description  => "List of extra groups that users will be added or removed to",
  :type         => "array",
  :recipes      => ['workstation_management::extra_groups']

attribute 'group_management/extra_groups/name',
  :display_name => "Group name",
  :description  => "Group name",
  :type         => "string",
  :validation   => "alphanumericwithdots",
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
  :validation   => "alphanumericwithdots",
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
  :validation   => "alphanumericwithdots",
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

