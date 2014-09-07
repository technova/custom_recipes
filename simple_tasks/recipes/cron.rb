#

# Cookbook Name:: simple
# Recipe:: cron
#


node[:crons].each do |cron_name, cron_data|
  cron_d cron_name do
    action :delete
  end
  env        = cron_data['environment_variables'] || ''
  log_file   = cron_data['log_file'] || '/var/log/cron.log'
  run_cmd   = cron_data['run_cmd']
  cron_user   = cron_data['user'] || 'root'

  cron cron_name do
    minute  cron_data['minute']
    hour    cron_data['hour']
    weekday cron_data['weekday'] if cron_data['weekday']
    path cron_data['path'] if cron_data['path']
    mailto  cron_data['mailto'] if cron_data['mailto']
    user    cron_user 
    cmd = ''
    cmd << "#{env} #{run_cmd} > #{log_file} 2>&1"
    command cmd
  end
end
