Vagrant PHP Development Box
========================

## Looking for PR :)!!!

> I had no more time to keep the box updated, so **the build is broken!**
> 
> You can still run it against Vagrant 1.x, however could be a good idea to upgrade it.
> Would you like to maintain this project? Feel free to send me a PR!

## Project Overview

A Vagrant project which aims you to get a feature rich **PHP** development box (VM). It provides a quite good number of tools and libraries, including those related to the *latest technologies*. The box is based on a fresh **Ubuntu 12.04** built using [veewee](https://github.com/jedi4ever/veewee) and provisioned by **Vagrant** via *Chef*.

## Applications and libraries

 - Apache 2, node.js
 - PHP (5.4), Composer, PHPUnit, xDebug
 - MySQL, Memcached, MongoDB (10gen), SQLite
 - NFS, GhostScript, ImageMagick, Vim, Ruby (Gems: Compass, Less, SASS)

## Usage

1. Install [VirtualBox](http://www.virtualbox.com) and [Vagrant](http://vagrantup.com).

2. Open a **Terminal**, `cd` to your working directory, clone the project:

    `git clone git://github.com/morafabio/vagrant-php-development-box.git`

3. Edit the **Vagrantfile.sample** and customize it as you need. Save it as **Vagrantfile**.

4. Run `vagrant up` to provision it, should take a few minutes.

5. (If you want to get a shell type `vagrant ssh`).
 
## Default parameters

    VM IP:              33.33.33.10
    System user:        vagrant
    System password:    vagrant
    MySQL user:         root
    MySQL password:     root
    xDebug Remote:      33.33.33.1

## Configure your projects

 1. You can add multiple projects and mountpoints editing `Vagrantfile`. Look for `web_apps` definition.

Here's the outline:
  
    "host_project_folder"  host side, where your project resides
    "guest_project_folder" vm side, where host_project_folder is mounted on via vboxsf
    "guest_docroot"        vm side, the Apache2 docroot
    "server_name"          Apache2: ServerName
    "server_aliases"       Apache2: ServerAlias
    "php_timezone"         php.ini project's timezone

And an example:

    web_apps = {
      "site1" => {
        "host_project_folder"  => "../web-app-1/",
        "guest_project_folder" => "/home/vagrant/web-app-1",
        "guest_docroot"        => "/home/vagrant/web-app-1/web",
        "server_name"          => "webapp1.test.local",
        "server_aliases"       => ["*.webapp1"],
        "php_timezone"         => "Europe/Rome"
      },
      "site2" => {
        "host_project_folder"  => "../web-app-2/",
        "guest_project_folder" => "/home/vagrant/web-app-2",
        "guest_docroot"        => "/home/vagrant/web-app-2/web",
        "server_name"          => "webapp2.test.local",
        "server_aliases"       => [],
        "php_timezone"         => "America/New_York"
      }
    }

  2. Run `vagrant provision`.

## To Do

   - [!!!] Fix the box in order to run the latest Vagrant stable version.
   - [!!] Update the Linux basebox with a fresh veewee generation. 
   - [!!] Update recipes.
   - Reorganize the chef cookbook provisioning strategy, in order to get the latest recipes version.
   - A CentOS version and a 32 bit edition: make the base box compatibile with other O.S...?
   - *VirtualBox Guest Additions* should be easily upgradable.
   - ~~Workaround the `vboxsf` [cache bug] (https://forums.virtualbox.org/viewtopic.php?f=3&t=33201)~~

## Credits

Fabio Mora 2013, [fabiomora.com](http://fabiomora.com).

Some projects from which I took the code and inspiration, thanks!

 - [symfony-vagrant](https://github.com/simshaun/symfony-vagrant)
 - [veewee](https://github.com/jedi4ever/veewee)
 - Chef Cookbooks: look for README.md inside each directories' for details.

