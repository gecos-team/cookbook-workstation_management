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

attribute 'group_management/admin_groups',
  :display_name => "Local admin groups",
  :description  => "List of local admin groups",
  :type         => "array",
  :default      => "[{'group':'admin'},{'group':'adm'}]",
  :recipes      => ['group_management::group_management']


attribute 'group_management/admin_groups/group',
  :display_name => "Local admin group",
  :type         => "string",
  :validation   => "custom",
  :custom       => "^[\W]",
  :order        => "0",
  :recipes      => ['group_management::group_management']

attribute 'group_management/admin_users_to_add',
  :display_name => "Users to add to admin groups",
  :description  => "List of users that will be added to admin groups",
  :type         => "array",
  :default      => "[]",
  :recipes      => ['group_management::group_management']

attribute 'group_management/admin_users_to_add/user',
  :display_name => "User to add to admin groups",
  :description  => "User will be added to admin groups",
  :type         => "string",
  :validation   => "custom",
  :custom       => "^[\W]",
  :order        => "1",
  :recipes      => ['group_management::group_management']

attribute 'group_management/admin_users_to_remove',
  :display_name => "Users to remove from admin groups",
  :description  => "List of users that will be remove from admin groups",
  :type         => "array",
  :default      => "[]",
  :recipes      => ['group_management::group_management']

attribute 'group_management/admin_users_to_remove/user',
  :display_name => "User to remove from admin groups",
  :description  => "User will be remove from admin groups",
  :type         => "string",
  :validation   => "custom",
  :custom       => "^[\W]",
  :order        => "2",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_groups',
  :display_name => "Local base groups",
  :description  => "List of local base groups",
  :type         => "array",
  :default      => "[{'group':'base'},{'group':'adm'}]",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_groups/group',
  :display_name => "Local base group",
  :type         => "string",
  :validation   => "custom",
  :custom       => "^[\W]",
  :order        => "3",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_users_to_add',
  :display_name => "Users to add to base groups",
  :description  => "List of users that will be added to base groups",
  :type         => "array",
  :default      => "[]",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_users_to_add/user',
  :display_name => "User to add to base groups",
  :description  => "User will be added to base groups",
  :type         => "string",
  :validation   => "custom",
  :custom       => "^[\W]",
  :group        => "4",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_users_to_remove',
  :display_name => "Users to remove from base groups",
  :description  => "List of users that will be remove from base groups",
  :type         => "array",
  :default      => "[]",
  :recipes      => ['group_management::group_management']

attribute 'group_management/base_users_to_remove/user',
  :display_name => "User to remove from base groups",
  :description  => "User will be remove from base groups",
  :type         => "string",
  :default      => "[]",
  :validation   => "custom",
  :custom       => "^[\W]",
  :order        => "5",
  :recipes      => ['group_management::group_management']
