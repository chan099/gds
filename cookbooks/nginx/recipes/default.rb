# Recipe: nginx::default

include_recipe 'nginx::package'
include_recipe 'nginx::service'
include_recipe 'nginx::conf'
