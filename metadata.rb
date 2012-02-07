name              "workstation_management"
maintainer        "Roberto C. Morano"
maintainer_email  "rcmorano@emergya.com"
license           "Apache 2.0"
description       "Cookbook that provides recipes for GECOS workstations administration"
version           "0.1.1"


provides          "workstation_management::group_management"
recipe            "workstation_management::group_management", "Add or Remove users from given groups lists"

provides            "workstation_management::create_files"
provides            "workstation_management::remove_files"
recipe            "workstation_management::create_files", "Copy remote files to the Chef node."
recipe            "workstation_management::remove_files", "Remove local files of the Chef node."
%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'fixed_files/create_files',
  :display_name => "Create Files",
  :description  => "List of files",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'workstation_management::create_files' ]
  
attribute 'fixed_files/create_files/file_url',
  :display_name => "File Url",
  :description  => "Url that contains the file",
  :type         => "string",
  :required     => "required",
  :validation   => "url",
  :order        => "0",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/create_files/path_client',
  :display_name => "Path client",
  :description  => "Path to copy file in to the client",
  :type         => "string",
  :required     => "required",
  :validation   => "abspath",
  :order        => "1",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/create_files/user',
  :display_name => "Own",
  :description  => "File's owner username",
  :type         => "string",
  :required     => "required",
  :wizard       => "users",
  :order        => "2",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/create_files/group',
  :display_name => "Owner group",
  :description  => "File's owner group",
  :type         => "string",
  :required     => "required",
  :wizard       => "groups",
  :order        => "3",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/create_files/mode',
  :display_name => "Mode",
  :description  => "Mode of file (in e.g 0775)",
  :type         => "string",
  :required     => "required",
  :validation   => "modefile",
  :order        => "4",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/create_files/override',
  :display_name => "Override",
  :description  => "Create the file locally only if the file doesn't yet exist",
  :type         => "string",
  :required     => "required",
  :choice       => [ "true", "false" ],
  :order        => "5",
  :recipes      => [ 'workstation_management::create_files' ]

attribute 'fixed_files/remove_files',
  :display_name => "Remove Files",
  :description  => "List of files",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'workstation_management::remove_files' ]

attribute 'fixed_files/remove_files/file_path',
  :display_name => "File Path",
  :description  => "Path that contains the file",
  :type         => "string",
  :required     => "required",
  :validation   => "abspath",
  :order        => "0",
  :recipes      => [ 'workstation_management::remove_files' ]


attribute 'group_management/admin_users_to_add',
  :display_name => "Users to add to admin groups",
  :description  => "List of users that will be added to admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/admin_users_to_add/user',
  :display_name => "User to add to admin groups",
  :description  => "User will be added to admin groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "0",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/admin_users_to_remove',
  :display_name => "Users to remove from admin groups",
  :description  => "List of users that will be remove from admin groups",
  :type         => "array",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/admin_users_to_remove/user',
  :display_name => "User to remove from admin groups",
  :description  => "User will be remove from admin groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "1",
  :recipes      => ['workstation_management::group_management']


attribute 'group_management/base_users_to_add',
  :display_name => "Users to add to base groups",
  :description  => "List of users that will be added to base groups",
  :type         => "array",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/base_users_to_add/user',
  :display_name => "User to add to base groups",
  :description  => "User will be added to base groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :group        => "2",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/base_users_to_remove',
  :display_name => "Users to remove from base groups",
  :description  => "List of users that will be remove from base groups",
  :type         => "array",
  :recipes      => ['workstation_management::group_management']

attribute 'group_management/base_users_to_remove/user',
  :display_name => "User to remove from base groups",
  :description  => "User will be remove from base groups",
  :type         => "string",
  :validation   => "alphanumericwithdots",
  :order        => "3",
  :recipes      => ['workstation_management::group_management']
