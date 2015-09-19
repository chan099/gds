# Recipe sudo::dir

directory '/etc/sudoers.d' do
  owner 'root'
  group 'root'
  mode '0770'
  action :create
end
