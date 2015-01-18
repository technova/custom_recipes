#
# Cookbook Name:: run_bluepill
# Recipe:: default
#
# Copyright 2014, Saviance.com
#
# All rights reserved - Do Not Redistribute
#



node[:deploy].each do |application, deploy|
  folder_path = "/srv/www/#{application}/current"
  Chef::Log.debug("automatic blue pill script for #{application} with #{deploy[:rails_env]}")
  execute "run_bluepill" do
    cwd folder_path
    command "sudo RAILS_ENV=#{deploy[:rails_env]} bundle exec bluepill load ./config/dj_bluepill.pill && sudo RAILS_ENV=#{deploy[:rails_env]} bundle exec bluepill start"
    action :run
    only_if do 
      File.exists?(folder_path) && deploy[:rails_env]
    end
  end
  Chef::Log.debug("Skipping Other Env")
  break
end