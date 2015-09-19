# Recipe sudo::default

include_recipe 'sudo::sudoers'
include_recipe 'sudo::dir'
include_recipe 'sudo::vagrant'
include_recipe 'sudo::admins'
