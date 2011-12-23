#
# Cookbook Name:: group_management
# Recipe:: base_groups
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * David Amian Valle <damian@emergya.com>
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

['dialout', 'fax', 'cdrom', 'floppy', 'tape', 'audio', 'dip', 'video', 'plugdev', 'fuse', 'sambashare'].each do |base_g|
  group base_g do
    action :modify
    members node["base_groups"]["to_add"]
    append true
  end
end


['dialout', 'fax', 'cdrom', 'floppy', 'tape', 'audio', 'dip', 'video', 'plugdev', 'fuse', 'sambashare'].each do |base_g|
  members_group = Etc.getgrnam(base_g).mem
  members_group= members_group + (node["administrator_group"]["to_add"] - members_group)
  members_group = members_group - node["base_groups"]["to_remove"]
  group base_g do
    action :modify
    members members_group
    append false
  end
end
