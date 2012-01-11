#
# Cookbook Name:: group_management
# Recipe:: default
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

node[:group_management].each do |grp_list,values|
  node[:group_management][grp_list][:groups].each do |grp|
    grp_members = Etc.getgrnam(grp).mem
    grp_members = grp_members + node[:group_management][grp_list][:users_to_add]
    unless grp_members.empty?
      grp_members = grp_members - node[:group_management][grp_list][:users_to_remove]
      grp_members.uniq!
  
      group grp do
        action :manage
        members grp_members
        append false
      end
    end
  end
end
