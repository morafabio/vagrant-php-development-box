#
# Cookbook Name:: phpunit
# Attributes:: default
#
# Copyright 2012, Escape Studios
#

default[:phpunit][:install_method] = "pear"
default[:phpunit][:version] = "latest"

#composer install only
default[:phpunit][:prefix] = "/usr/bin"