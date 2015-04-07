execute "echo 'deb http://rep.logentries.com/ precise main' > /etc/apt/sources.list.d/logentries.list" do
  user "root"
end

execute "gpg --keyserver pgp.mit.edu --recv-keys C43C79AD && gpg -a --export C43C79AD | apt-key add -" do
  user	"root"
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
