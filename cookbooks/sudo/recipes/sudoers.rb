# Recipe: sudo::sudoers

cookbook_file '/etc/sudoers' do
  source 'sudoers'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end
