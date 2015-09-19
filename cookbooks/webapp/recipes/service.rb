# Recipe: webapp::service

# Needed for the init script
package 'daemon' do
  action :install
end

cookbook_file '/etc/init.d/helloworld' do
  source 'helloworld.init'
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

service 'helloworld' do
  action [ :enable, :start ]
end
