#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/apt/sources.list.d/mc3man-trusty-media-trusty.list' do
  source 'mc3man-trusty-media-trusty.erb'
  action :create_if_missing
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'ffmpeg' do
  package_name 'ffmpeg'
  action :install
end

package 'gstreamer0.10-ffmpeg' do
  package_name 'gstreamer0.10-ffmpeg'
  action :install
end