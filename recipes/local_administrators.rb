#
# Cookbook Name:: workstation_management
# Recipe:: admin_groups
#
# Copyright 2011 Junta de Andalucía
#
# Authors::
#  * David Amian Valle <damian@emergya.com>
#  * Roberto C. Morano <rcmorano@emergya.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'etc'

admin_groups = node["local_administrators"]["admin_groups"]

admin_groups.each do |grp|
  if !grp["name"].empty?
    grp_members = Etc.getgrnam(grp["name"]).mem
  
    users_to_add = []
    users_to_remove = []
  
    admin_users_to_add = node["local_administrators"]["admin_users_to_add"]
    admin_users_to_add.each do |user|
      users_to_add << user["user"] unless user["user"].empty?
    end
  
    admin_users_to_remove=node["local_administrators"]["admin_users_to_remove"]
    admin_users_to_remove.each do |user|
      users_to_remove << user["user"] unless user["user"].empty?
    end
  
    grp_members = grp_members + users_to_add
    unless grp_members.empty?
      grp_members.uniq!
      grp_members = grp_members - users_to_remove
      grp_members.uniq!
  
      group grp["name"] do
        action :manage
        members grp_members
        append false
      end
    end
  end
end
