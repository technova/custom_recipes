apt_repository 'logentries' do
  uri 'http://rep.logentries.com/'
  distribution node['lsb']['codename']
  components ['main']
  keyserver node['le']['pgp_key_server']
  key 'C43C79AD'
end

execute "apt-get update" do
  user	"root"
end

execute "apt-get install python-setproctitle logentries logentries-daemon" do
  user "root"
end

execute 'initialize logentries daemon' do
    cmd = "le register"
              cmd += " --user-key #{node['le']['account_key']}"
              cmd += " --name='#{node['le']['hostname']}'"
    command(cmd)

    not_if 'le whoami'
    user "root"
    notifies :restart, 'service[logentries]'
end


execute "le follow log" do
  cmd="le follow '#{node['le']['logs_to_follow']}'"
  command(cmd)
  user "root"
  notifies :restart, 'service[logentries]'
end
