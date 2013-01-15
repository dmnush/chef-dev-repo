#
# Cookbook Name:: secweb_httpd
# Recipe:: secweb_proxy
#
# This recipe installs the customized Apache web server for Astra VMs,
# customized to function only as an HTTP proxy.  The specific proxypass
# rules will need to be installed by each individual application.
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

# Enable HTTP Proxy (should save a full config file in 'files', but
# for now just edit the default httpd.conf in-place)
script "configure_proxy" do
   interpreter "bash"
   code <<EOH
sed --in-place=".orig" -e '{
/mod_proxy.so/ s/#Load/Load/
/mod_proxy_http.so/ s/#Load/Load/
}' /usr/local/apache2/conf/httpd.conf
EOH
end
