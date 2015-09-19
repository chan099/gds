# Recipe: webapp::user

user 'webapp' do
  home '/opt/helloworld'
  shell '/bin/false'
end
