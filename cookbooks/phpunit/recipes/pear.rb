#
# Cookbook Name:: phpunit
# Recipe:: pear
#
# Copyright 2012, Escape Studios
#

include_recipe "php"

#PHP Extension and Application Repository PEAR channel
pearhub_chan = php_pear_channel "pear.php.net" do
  action :update
end

#upgrade PEAR
php_pear "PEAR" do
	channel pearhub_chan.channel_name
	action :upgrade
end

#Symfony2 PEAR channel
php_pear_channel "pear.symfony.com" do
    action :discover
end

#PHPUnit PEAR channel
pearhub_chan = php_pear_channel "pear.phpunit.de" do
	action :discover
end

#upgrade PHPUnit
php_pear "PHPUnit" do
	channel pearhub_chan.channel_name
	if node[:phpunit][:version] != "latest"
		version "#{node[:phpunit][:version]}"
	end
	action :upgrade
end