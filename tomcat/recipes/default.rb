#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.7.0-openjdk'

remote_file '/root/apache-tomcat-8.5.16.tar.gz' do
  source 'http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz'
  owner 'root'
  group 'root'
  mode 0755
  action :create
  not_if { File.exist?("/root/apache-tomcat-8.5.16") }
end

bash 'untar tomcat' do
  cwd '/root'
  code <<-EOH
    tar -xf apache-tomcat-8.5.16.tar.gz
  EOH
  action :run
  not_if { File.exist?("/root/apache-tomcat-8.5.16") }
end

bash 'start tomcat' do
  cwd '/root/apache-tomcat-8.5.16/bin'
  code <<-EOH
    sh startup.sh
  EOH
  action :run
  not_if 'netstat -nlp | grep 8080'
end

bash 'clean intermidiate files' do
  cwd '/root'
  code <<-EOH
    rm -f apache-tomcat-8.5.16.tar.gz
  EOH
  action :run
  only_if { File.exist?("/root/apache-tomcat-8.5.16.tar.gz") }
end

