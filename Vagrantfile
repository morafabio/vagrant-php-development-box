# -----------------------------------------------------------------------------
# Configuration:
# -----------------------------------------------------------------------------

# web_apps:
#   app_identifier => { .. app settings .. }
#
# App Settings:
# ------------------------------------------------------
# host_project_folder:  Where project resides on the host
#                         default: relative to the vagrant folder
# guest_project_folder: Where the project resides in the guest VM
# guest_docroot:        Where Apache serves files within the guest VM
# server_name:          Same as Apache's ServerName
# server_aliases:       Same as Apache's ServerAlias
 
php_timezone_cli = "Europe/Rome"

web_apps = {
  "project1" => {
    "host_project_folder"  => "../",
    "guest_project_folder" => "/home/vagrant/web-app",
    "guest_docroot"        => "/home/vagrant/web-app/web",
    "server_name"          => "localhost",
    "server_aliases"       => ["*.localhost"],
    "php_timezone"         => "Europe/Rome"
  }
}

# You can probably get away with not changing these:
# guest_ip:   IP address that guest is accessible from on the host
# host_port:  Guest VM will forward port 80 to this port on the host

guest_ip              = "33.33.33.10"
host_port             = 8080
xdebug_remote_enabled = 1
xdebug_remote_host    = "33.33.33.1"
xdebug_remote_port    = 9000

# -----------------------------------------------------------------------------

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-12.04.2-server-amd64-dist"
  config.vm.box_url = "http://static.techeffe.net/vagrant/ubuntu-12.04.2-server-amd64-dist.box"

  # Configure VM RAM usage
  # config.vm.memory_size = 512

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  config.vm.network :hostonly, guest_ip
  config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, host_port

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder("web-app", "/home/vagrant/web-app", "../", :owner => "vagrant")
  web_apps.each do |id, web_app|
    config.vm.share_folder(id, web_app["guest_project_folder"], web_app["host_project_folder"], :owner => "vagrant")
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"    
    chef.add_recipe "vagrant_main"
    
    chef.json = {
      "app" => {
        "web_apps"         => web_apps,
        "php_timezone_cli" => php_timezone_cli
      },
      "xdebug" => {
        "remote_enable" => xdebug_remote_enabled,
        "remote_host"   => xdebug_remote_host,
        "remote_port"   => xdebug_remote_port
      }
    }
  end
end
