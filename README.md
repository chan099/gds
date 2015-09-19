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

## Steps
## Setup vagrant
* Add vagrant box:
`vagrant box add https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm`
* Chose virtualbox when prompted
* Create vagrant dir and Vagrantfile with specified box (commit 240586cab72536cb444fe934b1690d17d747e8ea)
* Add Chef provisioner to Vagrantfile (commit 15b65d79cf01d0ca4dd1f67c35631b42b4ec34bb)

## Nginx install and test
Note: I would evaluate and possibly use the supermarket cookbook for Nginx in the real world, but just sticking with a basic hand written one for this exercise.

* Create dir structure for nginx cookbook (./cookbooks/nginx)
* Create default recipe for nginx cookbook (./cookbooks/nginx/recipes/default.rb)
* Create package recipe with package resource (./cookbooks/nginx/recipes/package.rb) and include this in the default recipe (commit c09ba194fe7a29d0784c2120a4a46c60b768758f)
* Ensure nginx is running with service resource in service recipe (commit 4aa231dc96ea4eaf2515f528b1711e61d4551099)
* Add test_nginx.sh script to test Nginx is running on localhost:80
* Add a provision block to the Vagrantfile to run test_nginx.sh (commit 693c0fc33532f1890729d7a5fb039d64f01e2e4d)
