#
# Cookbook Name:: tomcat7
# Recipe:: restart
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Installs tomcat 7 using yum and starts
#
#

# Restart
service "tomcat7" do
   action [:restart]
end
