#
# Cookbook Name:: install_modpagespeed
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "#{Chef::Config[:file_cache_path]}/mod-pagespeed.deb" do
source node['apache2']['mod_pagespeed']['package_link']
mode '0644'
action :create_if_missing
end
package 'mod_pagespeed' do
source "#{Chef::Config[:file_cache_path]}/mod-pagespeed.deb"
action :install
end
apache_module 'pagespeed' do
conf true
end