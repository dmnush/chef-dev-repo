#
# Cookbook Name:: astra_core
# Recipe:: astra_base
#
# This recipe installs base packages and files for Astra servers.
#
# Copyright 2012, AT&T
# All rights reserved - Do Not Redistribute
#

# Install KSH
package "ksh" do
   version  "20100621-16.el6"
   action   :install
end

# Install environment-specific hosts file
cookbook_file "/etc/hosts" do
   action :create
   source "hosts-#{node.chef_environment}"
   mode 0644
   owner "root"
   group "root"
end
