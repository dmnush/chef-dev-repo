#
# Cookbook Name:: secweb_httpd
# Recipe:: default
#
# This recipe installs the customized Apache web server for Astra VMs.
# This will be needed by most gold (and purple) boxes that implement an
# HTTP interface, and will use Apache to proxy incoming requests.
#
# This is a default configuration (which will only serve the default
# document root).  Other recipes in this cookbook contain more specific
# installation options.
#

# Install secweb-httpd (apache2).  Don't start it.
package "secweb-httpd" do
   version "2.2.21-12"
   action :install
end

# Create the default document root so httpd will start.
directory "/var/www" do
   action :create
   owner "apache"
   group "root"
   mode  00755
end
