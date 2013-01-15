#
# Cookbook Name:: sis
# Recipe:: sis_eutil
#
# This recipe installs the sis eutil libraries onto a VM.
# Additional sis packages are included in other recipes.
#

package "sis-libs-eutil-es6" do
   version "1.2-1243"
   action :install
end

