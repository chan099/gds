# Recipe sudo::vagrant

template '/etc/sudoers.d/vagrant' do
  source 'vagrant.sudoers.erb'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end
