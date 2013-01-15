#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Installs tomcat 7 using yum and starts
#
#

# Install/upgrade tomcat
package "apache-tomcat" do
   action [:upgrade]
end

# Set to start automatically and start
service "tomcat7" do
   supports :status => true, :restart => true
   action [:enable,:start]
end
