# GDS

# Tasks
* Create a Vagrantfile that creates a single machine using this box: https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm
* and installs the latest released version of your chosen config management tool
* Install the nginx webserver via cfg mgmt.
* Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80
* Manage the contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admins group can sudo with a password.
* Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made
* Create a simple "Hello World" web application in your favourite language of choice
* Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.
* Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.

# Notes
* Time: I took about 5 hours; longer than stated but I was determined to get the load balanced web app set up.
* I would evaluate and possibly use the supermarket cookbook for Nginx and sudo in the real world, but just sticking with basic hand written ones for this exercise.
* The vagrant user and admins group are not created as it's not stated to do so, I would add them as part of this build.
* The webapp runs with a horrible execute resource as root, I would not do either of those in the real world but was wasting too much time getting it daemonized as a non-priveleged user.
* Also in the webapp cookbook is an execute statement for the Ubuntu ufw firewall config, in the real world I would have created a seperate cookbook for this with proper file management (or used a community cookbook). It also turns out it was not needed as ufw is inactive as default.
* For some reason the Hello World app doesn't always output Hello World but seems to always output the 200 OK header.

# Instructions
* Ensure you have Vagrant and Virtualbox installed
 * My versions: vagrant => 1.7.2, virtualbox => 4.3.30
* Clone this repo
* Change to the 'vagrant' directory
* Run `vagrant up`
* Go to http://localhost:8080 to see 'Hello World' (can take several tries to actually get the 'Hello World' output)

# Steps
## Setup vagrant
* Add vagrant box:
`vagrant box add https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm`
* Chose virtualbox when prompted
* Create vagrant dir and Vagrantfile with specified box
* Add Chef provisioner to Vagrantfile

## Nginx install and test

* Create dir structure for nginx cookbook (./cookbooks/nginx)
* Create metadata file (./cookbooks/nginx/metadata.rb)
* Creare recipes:
 * default: Includes other recipes
 * service: Manages the Nginx service
 * package: Installs Nginx version specified, and keeps it at that version through the upgrade action
 * conf: Manages Nginx configuration files using template resources. Nginx will not restart if these files not not changed, preserving idempotency
* Add test_nginx.sh script to test Nginx is running on localhost:80
* Add a provision block to the Vagrantfile to run test_nginx.sh

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

## Hello World webapp
* Copied and modified code from here: http://www.binarytides.com/python-socket-server-code-example/
 * Just added basic HTTP header and 'Hello World' output
* Create dir structure for webapp cookbook (./cookbooks/sudo/{recipes,files/default)
* Create metadata file (./cookbooks/webapp/metadata.rb)
* Create recipes:
 * default: Includes other recipes
 * app: Installs and runs webapp
 * user: Creates a non-privileged user to run the webapp
 * service: Runs the app as a service (not working)
* Modify the Vagrantfile to create three machines: a proxy (running nginx) and two app servers
* Modify the Vagrantfile to create a private network so the proxy can communicate with the app servers
* Add port forwarding from the host port 8080 to proxy port 80 in the Vagrantfile
