#
# Cookbook Name:: networking_basic
# Recipe:: default
#
#

node['networking']['packages'].each do |netpkg|
  package netpkg
end
