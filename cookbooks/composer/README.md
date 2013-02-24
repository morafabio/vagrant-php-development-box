Description
===========
A cookbook to install [Composer](http://getcomposer.org) and maintain composer packages within project deployments.

Requirements
============
n/a

Attributes
==========

 - `:install_path`: The path which composer will be installed
 - `:owner`: The owner of the file
 - `:dev`: Whether to execute the project activities with the `--dev` flag.

```ruby
default[:composer][:install_path] = "/usr/local/bin"
default[:composer][:owner] = "root" # apache|www-data|root|whatever
default[:composer][:project][:dev] = false
```

Usage
=====

## `composer`

### Actions:

 - `:install`
 - `:uninstall`
 - `:update`
 
### Example:

```ruby
composer "/usr/local/bin" do
  owner "root" # optional
  action [:install, :update]
end

composer "/usr/local/bin" do
  action :uninstall
do
```

## `composer_project`

### Actions:
 - `:install`
 - `:update`
 - `:dump_autoload`
 
### Example:

```ruby
composer_project "/var/www/pr1" do
 dev true # optional
 run_as "www-data" # optional
 composer_path "/usr/local/bin" #optional
 action [:install, :update, :dump_autoload]
end
```
## `composer_project_package`

create a custom project from a specific package like symfony (recipe as an example)

## Actions:
- `:install`
- `:update`

### Example:

```ruby
composer_project_packages "symfony/framework-standard-edition" do
	project_packpath "/var/www"
	project_packfolder "Symfony"
	project_packversion "2.1.7"
	dev false
  	action [:install]
end
```

## `Recipe Symfony`

This recipe install symfony in default folder define or by cutomize the folowing attributes :

### Attributes

 - `:sfpath`: The path which Symfony will be installed
 - `:sffolder`: The directory inside the path
 - `:sfversion`: The Symfony version to install
 - `:sfuser`: Owner
 - `:sfgroup`: Owner's group


```ruby
default[:composer][:sfpath] = "/var/www"
default[:composer][:sffolder] = "Symfony"
default[:composer][:sfversion] = ""
default[:composer][:sfuser] = "vagrant"
default[:composer][:sfgroup] = "vagrant"
```
