#
# Cookbook Name:: sis
# Recipe:: sis_base
#
# This recipe installs the base sis packages onto a VM.
# This includes sis-base, sis-admin, and sis-libs-common.
# Additional sis packages are included in other recipes.
#

package "sis-base-es6" do
   version "1.2-1243"
   action :install
end

package "sis-admin-es6" do
   version "1.2-1243"
   action :install
end

package "sis-libs-common-es6" do
   version "1.2-1243"
   action :install
end
