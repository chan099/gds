# Recipe: sudo::admins

template '/etc/sudoers.d/admins' do
  source 'admins.sudoers.erb'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end
