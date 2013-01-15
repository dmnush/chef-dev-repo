# Cookbook:  astra_logger
# Recipe: omss_logger
# #
# This recipe installs the omss-logger packages for the Astra Logger
# gold box.  The package list matches "log.conf" from the current 
# sbuild.sh-based install.

package "omss-logger" do
   version "1.0.0-10"
   action :install
end
