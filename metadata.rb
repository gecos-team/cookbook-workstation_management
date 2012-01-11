name              "group_management"
maintainer        "Roberto C. Morano"
maintainer_email  "rcmorano@emergya.com"
license           "Apache 2.0"
description       "Manage users in local groups"
version           "0.1.1"

provides          "group_management::group_management"
recipe            "group_management::group_management", "Add or Remove users from given groups lists"

%w{ redhat centos fedora ubuntu debian }.each do |os|
  supports os
end

attribute 'group_management/group_management',
  :display_name => "Groups lists",
  :description  => "List of groups lists",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'group_management::default' ]

attribute 'group_management/group_management/administrator',
  :display_name => "Administrators groups list",
  :description  => "",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'group_management::default' ]

attribute 'group_management/group_management/administrator/groups',
  :display_name => "Local admin groups",
  :description  => "List of local admin groups",
  :type         => "array",
  :default      => ['admin','adm'],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']

attribute 'group_management/group_management/administrator/users_to_add',
  :display_name => "Users to add to admin groups",
  :description  => "List of users that will be added to admin groups",
  :type         => "array",
  :default      => [],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']

attribute 'group_management/group_management/administrator/users_to_remove',
  :display_name => "Users to remove from admin groups",
  :description  => "List of users that will be remove from admin groups",
  :type         => "array",
  :default      => [],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']

attribute 'group_management/group_management/base',
  :display_name => "Base groups list",
  :description  => "",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'group_management::default' ]

attribute 'group_management/group_management/base/groups',
  :display_name => "Local base groups",
  :description  => "List of local base groups",
  :type         => "array",
  :default      => ['base','adm'],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']

attribute 'group_management/group_management/base/users_to_add',
  :display_name => "Users to add to base groups",
  :description  => "List of users that will be added to base groups",
  :type         => "array",
  :default      => [],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']

attribute 'group_management/group_management/base/users_to_remove',
  :display_name => "Users to remove from base groups",
  :description  => "List of users that will be remove from base groups",
  :type         => "array",
  :default      => [],
  :validation   => "custom",
  :custom       => "^[\W]",
  :recipes      => ['group_management::default']
