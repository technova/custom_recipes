#
# Cookbook Name:: s3-config
# Recipe:: generate
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not s3tribute
node[:deploy].each do |app_name, deploy_config|
  # determine root folder of new app deployment
  app_root = "#{deploy_config[:deploy_to]}/current"

  # use template 's3.yml.erb' to generate 'config/s3.yml'
  template "#{app_root}/config/s3.yml" do
    source "s3.yml.erb"
    cookbook "s3-config"

    # set mode, group and owner of generated file
    mode "0660"
    group deploy_config[:group]
    owner deploy_config[:user]

    # define variable “@s3” to be used in the ERB template
    variables(
      :deploy_config => deploy_config || {}
    )

    # only generate a file if there is s3 configuration
    not_if do
      deploy_config[:s3].blank?
    end
  end
end