#
# Cookbook Name:: astra_core
# Recipe:: omss_repo
#
# This recipe installs the OMSS yum repository.
# It relies on the repository IP address being available in the 
# node's environment definition (e.g. in "dev" or "itl" environment).
#
# Copyright 2012, AT&T
# All rights reserved - Do Not Redistribute
#

template "/etc/yum.repos.d/omss.repo" do
   source "omss.repo.erb"
   variables :repo_ip => node['omss_repo_addr']
   action :create
   mode 0644
end
