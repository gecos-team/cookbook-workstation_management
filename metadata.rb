name              "group_management"
maintainer        "David Amian"
maintainer_email  "damian@emergya.com"
license           "Apache 2.0"
description       "Add or Remove users from local groups"
version           "0.1.1"

recipe            "group_management::administrator_group", "Add or Remove users to admin group"
recipe            "group_management::base_groups", "Add or Remove users to base groups"

%w{ redhat centos fedora ubuntu debian }.each do |os|
  supports os
end

attribute 'administrator_group/to_add',
  :display_name => "To add",
  :description  => "List of users to be added to admin group",
  :type         => "array"

attribute 'administrator_group/to_remove',
  :display_name => "To remove",
  :description  => "List of users to be removed to admin group",
  :type         => "array"

attribute 'base_groups/to_add',
  :display_name => "To add",
  :description  => "List of users to be added to defaults groups",
  :type         => "array"

attribute 'base_groups/to_remove',
  :display_name => "To remove",
  :description  => "List of users to be removed to defaults groups",
  :type         => "array"

