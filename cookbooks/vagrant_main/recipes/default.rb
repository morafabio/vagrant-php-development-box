node.set["apache"]["user"]  = "vagrant"
node.set["apache"]["group"] = "vagrant"

node.set['mysql']['server_root_password'] = "root"
node.set['mysql']['server_debian_password'] = "root"
node.set['mysql']['server_repl_password'] = "root"

node.set['mysql']['bind_address'] = node[:app][:ip]
node.set['mysql']['allow_remote_root'] = "1";

include_recipe "apt"

# Register PHP 5.4 PPA repository
apt_repository "php54" do
  uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end

include_recipe "networking_basic"

include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"

include_recipe "php"
include_recipe "phpunit"
include_recipe "composer"
include_recipe "xdebug"

include_recipe "mysql::server"

include_recipe "mongodb::10gen_repo"
include_recipe "mongodb"

package "nfs-kernel-server"
package "ghostscript"
package "git-core"
package "imagemagick"
package "memcached"
package "nodejs"
package "npm"
package "sqlite"
package "vim"

package "php-apc"
package "php5-cli"
package "php5-xsl"
package "php5-curl"
package "php5-gd"
package "php5-dev"
package "php5-intl"
package "php5-mcrypt"
package "php5-memcache"
package "php5-mysql"
package "php5-imagick"
package "php5-sqlite"
package "php5-tidy"
package "php5-xmlrpc"

php_pear "mongo" do
  action :install
end

gem_package "less"
gem_package "sass"
gem_package "compass"

template "/etc/php5/apache2/conf.d/custom_conf.ini" do
  source "php.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :php_timezone => node[:app][:php_timezone]
  })
end

template "/etc/php5/cli/conf.d/custom_conf.ini" do
  source "php.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :php_timezone => node[:app][:php_timezone]
  })
end

file "/etc/php5/apache2/conf.d/upload_path.ini" do
  owner "root"
  group "root"
  content "upload_tmp_dir = /tmp/web-app"
  action :create
end

apache_site "000-default" do
  enable false
end

node[:app][:web_apps].each do |identifier, app|
  web_app identifier do
    server_name app[:server_name]
    server_aliases app[:server_aliases]
    docroot app[:guest_docroot]
    php_timezone app[:php_timezone]
  end
end

# web_app "localhost" do
#  server_name node[:app][:server_name]
#  server_aliases node[:app][:server_aliases]
#  docroot node[:app][:docroot]
#  php_timezone node[:app][:php_timezone]
# end

group "vboxsf" do
  members 'vagrant'
  append true
end


