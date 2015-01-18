#
# Cookbook Name:: run_bluepill
# Recipe:: default
#
# Copyright 2014, Saviance.com
#
# All rights reserved - Do Not Redistribute
#
if node['folder'] && node['environment']
  folder_path = "/srv/www/#{node['folder']}/current"
  execute "run_bluepill" do
    command "cd #{folder_path} &&  sudo RAILS_ENV=#{node['environment']} bundle exec bluepill stop && sudo RAILS_ENV=#{node['environment']} bundle exec bluepill load #{folder_path}/config/dj_bluepill.pill && sudo RAILS_ENV=#{node['environment']} bundle exec bluepill start"
    action :run
  end
end
