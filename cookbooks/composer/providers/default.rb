#
# Cookbook Name:: composer
#
# Copyright 2012, Robert Allen
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

def whichfile(cmd)

  Chef::Log.debug("Executing which #{cmd}")

  shell = Chef::ShellOut.new("which " + cmd, :env => { 'PATH' => '/usr/bin:/usr/local/bin:/bin' })
  shell.run_command

  unless shell.exitstatus == 0
    return false
  else
    return true
  end
end

def find_php
  # verify if PHP is installed if not raise an error and stop
  @php_bin = whichfile("php")
  if !@php_bin 
    raise "PHP was not found."
  end
end


action :install do
  find_php()

  # verify if composer is not installed otherwise make an update
  if !::File.exists?("#{new_resource.install_path}/composer.phar")
    Chef::Log.info('Composer is not installed')
    remote_file "get-whickomposer" do
      not_if "test -f #{new_resource.install_path}/composer.phar"
      path "#{new_resource.install_path}/composer.phar"
      source "https://getcomposer.org/composer.phar"
      owner new_resource.owner
      mode 0755
    end
    execute "ln-composer" do
      not_if "test -f #{new_resource.install_path}/composer"
      command "ln -nsf #{new_resource.install_path}/composer.phar #{new_resource.install_path}/composer"
    end
  else
    Chef::Log.info('Composer is already installed then update')
    execute "self-update-composer-insteadinstall" do
      only_if "test -f #{new_resource.install_path}/composer.phar"
      command "#{new_resource.install_path}/composer.phar -n --no-ansi -q self-update"
    end
  end
end

action :uninstall do
  execute "unalias-composer" do
    only_if "test -f /etc/profile.d/composer.sh"
    command "unalias composer;rm -f /etc/profile.d/composer.sh"
  end
  execute "uninstall-composer" do
    only_if "test -f #{new_resource.install_path}/composer.phar"
    command "rm -f #{new_resource.install_path}/composer.phar"
  end
end

action :update do
  find_php()

  execute "self-update-composer" do
    only_if "test -f #{new_resource.install_path}/composer.phar"
    command "#{new_resource.install_path}/composer.phar -n --no-ansi -q self-update"
  end
end
