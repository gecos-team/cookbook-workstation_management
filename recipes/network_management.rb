#
# Cookbook Name:: workstation_management
# Recipe:: network_management
#
# Copyright 2011 Junta de Andalucía
#
# Author::
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

gem_depends = [ 'netaddr' ] 

gem_depends.each do |gem|

  r = gem_package gem do
    action :nothing
  end
  r.run_action(:install)

end
Gem.clear_paths

require 'netaddr'
require 'fileutils'

nm_conn_backup_dir = '/etc/NetworkManager/system-connections/chef-backups'
nm_conn_production_dir = '/etc/NetworkManager/system-connections/chef-conns'

unless Kernel::test('d', nm_conn_backup_dir)
  FileUtils.mkdir nm_conn_backup_dir
end

unless Kernel::test('d', nm_conn_production_dir)
  FileUtils.mkdir nm_conn_production_dir
end


nm_wired_dhcp_conn_source = 'wired-dhcp-conn.erb'
nm_wired_static_ip_conn_source = 'wired-static-ip-conn.erb'

nm_macaddress = node["macaddress"].gsub(/[0]([\w]:)/, '\\1')

nm_conn_files = []
Dir["/etc/NetworkManager/system-connections/*"].each do |conn_file|
  if Kernel::test('f', conn_file)
    unless open(conn_file).grep(/#{node["macaddress"]}/).empty? and open(conn_file).grep(/#{nm_macaddress}/).empty?
      nm_conn_files << conn_file
    end
  end
end

# parse dns servers
dns_servers = ""
node["network_management"]["dns_servers"].each do |server|
  if dns_servers.empty?
    dns_servers = server + ";" unless server.empty?
  else
    dns_servers = dns_servers + server + ";" unless server.empty?
  end
end

if node["network_management"]["conn_type"] == 'wired'
  if node["network_management"]["dhcp"] == 'true'
    unless nm_conn_files.empty?
      nm_conn_files.each do |conn_file|
        FileUtils.cp conn_file, nm_conn_backup_dir
        template_name = nm_conn_production_dir + "/" + File.basename(conn_file)
        template template_name do
          owner "root"
          group "root"
          mode 0600
          variables (:mac_address => nm_macaddress)
          source nm_wired_dhcp_conn_source
        end
      end
    else
      conn_file = "/etc/NetworkManager/system-connections/chef-conns/chef-managed-connection"
      template conn_file do
        owner "root"
        group "root"
        mode 0600
        variables (:mac_address => nm_macaddress)
        source nm_wired_dhcp_conn_source
      end
    end
  else
    netmask_int = NetAddr.netmask_to_i(node["network_management"]["netmask"])
    netmask = NetAddr.i_to_bits(netmask_int)
    unless nm_conn_files.empty?
      nm_conn_files.each do |conn_file|
        FileUtils.cp conn_file, nm_conn_backup_dir
        template_name = nm_conn_production_dir + "/" + File.basename(conn_file)
        template template_name do
          owner "root"
          group "root"
          mode 0600
          variables (:dns_servers => dns_servers,
                     :mac_address => nm_macaddress,
                     :ip_address => node["network_management"]["ip_address"],
                     :netmask => netmask,
                     :gateway => node["network_management"]["gateway"])
          source nm_wired_static_ip_conn_source
        end
      end
    else
      conn_file = "/etc/NetworkManager/system-connections/chef-conns/chef-managed-connection"
      template conn_file do
        owner "root"
        group "root"
        mode 0600
        variables (:dns_servers => dns_servers,
                   :mac_address => nm_macaddress,
                   :ip_address => node["network_management"]["ip_address"],
                   :netmask => netmask,
                   :gateway => node["network_management"]["gateway"])
        source nm_wired_static_ip_conn_source
      end
    end
  end
#else

end


cookbook_file "/etc/init/gecos-nm.conf" do
  source "gecos-nm.conf" 
  mode "0644"
  backup false
end
