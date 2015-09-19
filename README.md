# GDS
## Tasks
* Create a Vagrantfile that creates a single machine using this box: https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm
* and installs the latest released version of your chosen config management tool
* Install the nginx webserver via cfg mgmt.
* Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80
* Manage the contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admins group can sudo with a password.
* Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made
* Create a simple "Hello World" web application in your favourite language of choice
* Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.
* Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.

## Notes
I would evaluate and possibly use the supermarket cookbook for Nginx and sudo in the real world, but just sticking with basic hand written ones for this exercise.

## Steps
## Setup vagrant
* Add vagrant box:
`vagrant box add https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm`
* Chose virtualbox when prompted
* Create vagrant dir and Vagrantfile with specified box
* Add Chef provisioner to Vagrantfile

## Nginx install and test

* Create dir structure for nginx cookbook (./cookbooks/nginx)
* Create metadata file (./cookbooks/nginx/metadata.rb)
* Create default recipe for nginx cookbook (./cookbooks/nginx/recipes/default.rb)
* Create package recipe with package resource (./cookbooks/nginx/recipes/package.rb) and include this in the default recipe
* Ensure nginx is running with service resource in service recipe
* Add test_nginx.sh script to test Nginx is running on localhost:80
* Add a provision block to the Vagrantfile to run test_nginx.sh
* Add conf recipe which uses a template resource to manage nginx.conf, set to restart nginx when the file is changed
 * Nginx will not restart if this file is not changed, preserving idempotency

## Sudo
* Create dir structure for sudo cookbook (./cookbooks/sudo/{recipes,files/default,templates/default)
* Create metadata file (./cookbooks/sudo/metadata.rb)
* Create recipes:
 * default: Includes other recipes
 * sudoers: Uses a file resource to manage the sudoers file
 * dir: Uses a directory resource to manage the /etc/sudoers.d dir
 * vagrant: Uses a template resource to manage the vagrant file in /etc/sudoers.d which gives the 'vagrant' user sudo all with no password privileges
 * admins: Uses a template resource to manage the vagrant file in /etc/sudoers.d which gives users in the 'admins' group sudo all; they will be prompted for a password
* Create files and templates:
 * **Templates**
 *  vagrant.sudoers.erb: Adds sudo config for vagrant user
 * admins.sudoers.erb: Adds sudo config for admins group
 * **Files**
 * sudoers: Adds base sudoers file that includes the files in /etc/sudoers.d
* Add sudo recipe to the Vagrantfile
