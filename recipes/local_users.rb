#
# Cookbook Name:: workstation_management
# Recipe:: local_users
#
# Copyright 2012 Junta de Andalucía
#
# Authors::
#  * Alfonso de Cala <alfonso.cala@juntadeandalucia.es>
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

local_users = node["local_users"]["local_users"]

local_users.each do |user|

 if user["action"] == "create"
   begin
      user user["username"] do
        action :create
        comment "GECOS managed user"
        password user["password"]
        system true
        shell "/bin/bash"
      end  
   end
 end  

 if user["action"] == "delete"
   begin
      user user["username"] do
        action :remove
      end  
   end
 end  
end