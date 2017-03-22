#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'rhel'
  package 'httpd' do
    action :install
  end
  
  template "#{node['apache']['doc_root']}/#{node['apache']['index']}" do
    source 'index.html.erb'
    variables(
      :os => node['platform'],
      :os_ver => node['os_version'],
      :pri_ip => node['ipaddress']
    )
    notifies :restart, 'service[httpd]', :immediately
  end
  
  service 'httpd' do 
    action :start
  end
end

if node['platform_family'] == 'debian'
  package 'apache2' do
    action :install
  end

  template "#{node['apache']['doc_root']}/#{node['apache']['index']}" do
    source 'index.html.erb'
    variables(
      :os => node['platform'],
      :os_ver => node['os_version'],
      :pri_ip => node['ipaddress']
    )
    notifies :restart, 'service[apache2]', :immediately
  end

  service 'apache2' do
    action :start
  end
end
