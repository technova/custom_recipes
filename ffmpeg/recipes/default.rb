#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# sudo apt-add-repository ppa:mc3man/trusty-media
# sudo apt-get update
# sudo apt-get install ffmpeg gstreamer0.10-ffmpeg

# template '/etc/apt/sources.list.d/mc3man-trusty-media-trusty.list' do
#   source 'mc3man-trusty-media-trusty.erb'
#   action :create_if_missing
# end

execute "apt-add-repository -y ppa:mc3man/trusty-media" do
  user "root"
end

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
  user	"root"
  group	"root"
end

execute "apt-get -q -y install ffmpeg gstreamer0.10-ffmpeg" do
  user "root"
end
# package 'ffmpeg' do
#   package_name 'ffmpeg'
#   action :install
# end

# package 'gstreamer0.10-ffmpeg' do
#   package_name 'gstreamer0.10-ffmpeg'
#   action :install
# end