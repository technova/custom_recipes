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

execute "le register --user-key \"#{le['account_key']}\" --name=\"#{le['hostname']\"" do
  user "root"
end

execute "le follow \"#{le['logs_to_follow']}\"" do
  user "root"
end

execute "service logentries restart" do
  user	"root"
end