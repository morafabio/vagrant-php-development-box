#
# Cookbook Name:: composer
#
# Copyright 2012, Robert Allen
# AddOn Geraud Puechaldou
#
# @license    http://www.apache.org/licenses/LICENSE-2.0
#             Copyright [2012] [Robert Allen]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

action :install do
  if ::File.exists?("#{node['composer']['install_path']}/composer.phar")
    execute "install-composer-project-packages" do
      only_if "which composer >>/dev/null"
      user "#{new_resource.project_packuser}"
      group "#{new_resource.project_packgroup}"
      not_if "test -f #{new_resource.project_packpath}/#{new_resource.project_packfolder}/composer.lock"
      cwd new_resource.project_packpath
      dev = new_resource.dev ? "--dev" : ''
      # create project in cache folder and move it after because install could take a lot of time if directly in a shared folder
      command "composer create-project #{dev} #{new_resource.project_packname} #{Chef::Config[:file_cache_path]}/#{new_resource.project_packfolder}/ #{new_resource.project_packversion}"
    end
    execute "mv from cache to folder" do
      not_if "test -f #{new_resource.project_packpath}/#{new_resource.project_packfolder}/composer.lock"
      user "#{new_resource.project_packuser}"
      group "#{new_resource.project_packgroup}"
      # move from cache to the folder could be slow if folder is a shared
      command "mv #{Chef::Config[:file_cache_path]}/#{new_resource.project_packfolder}/ #{new_resource.project_packpath}/#{new_resource.project_packfolder}/"
    end
  else
    Chef::Log.info("Composer is not installed - " + "#{node['composer']['install_path']}/composer.phar")
  end
end
action :update do
  if ::File.exists?("#{new_resource.install_path}/composer.phar")
    execute "update-composer-project-packages" do
      only_if "which composer >>/dev/null"
      user "#{new_resource.project_packuser}"
      group "#{new_resource.project_packgroup}"
      cwd new_resource.project_packpath/new_resource.project_packfolder
      dev = new_resource.dev ? "--dev" : ''
      # update directly in the folder could be slow if the folder is shared
      command "composer update #{dev}"
    end
  else
    Chef::Log.info("Composer is not installed")
  end
end


