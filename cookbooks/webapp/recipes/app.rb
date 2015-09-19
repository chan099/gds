# Recipe: webapp::app

directory '/opt/helloworld' do
  owner 'webapp'
  group 'webapp'
  mode '0755'
  action :create
  recursive true
end

directory '/opt/helloworld/bin' do
  owner 'webapp'
  group 'webapp'
  mode '0755'
  action :create
end

directory '/opt/helloworld/log' do
  owner 'webapp'
  group 'webapp'
  mode '0755'
  action :create
end

cookbook_file '/opt/helloworld/bin/helloworld.py' do
  source 'helloworld.py'
  owner 'webapp'
  group 'webapp'
  mode '0744'
  action :create
end

execute 'start helloworld' do
  command 'nohup python2.7 /opt/helloworld/bin/helloworld.py > /opt/helloworld/log/stdout.log 2>&1 &'
  not_if 'ps -ef | grep helloworld.py'
  action :run
end
