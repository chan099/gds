# Recipe: nginx::service

service 'nginx' do
  action [ :enable, :start ]
end
