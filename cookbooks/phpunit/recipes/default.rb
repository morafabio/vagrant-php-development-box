#
# Cookbook Name:: phpunit
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

case node[:phpunit][:install_method]
	when "pear"
		include_recipe "phpunit::pear"
	when "composer"
		include_recipe "phpunit::composer"
end