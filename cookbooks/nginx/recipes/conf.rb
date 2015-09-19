# Recipe: nginx::conf

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[nginx]', :delayed
end

template '/etc/nginx/conf.d/proxy.conf' do
  source 'proxy.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[nginx]', :delayed
end
