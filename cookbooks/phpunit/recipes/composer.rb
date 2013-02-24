#
# Cookbook Name:: phpunit
# Recipe:: composer
#
# Copyright 2012, Escape Studios
#

include_recipe "composer"

phpunit_dir = "#{Chef::Config[:file_cache_path]}/phpunit"

directory "#{phpunit_dir}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
end

#figure out what version to install
if node[:phpunit][:version] != "latest"
	version = node[:phpunit][:version]
else
	version = "*.*.*"
end

#composer.json
template "#{phpunit_dir}/composer.json" do
	source "composer.json.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:version => version,
		:bindir => node[:phpunit][:prefix]
	)
end

#composer update
execute "phpunit-composer" do
	user "root"
	cwd phpunit_dir
	command "composer update"
	action :run
end