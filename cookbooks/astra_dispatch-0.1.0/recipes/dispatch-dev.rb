#
# Cookbook Name:: astra_dispatch
# Recipe:: dispatch-dev
#
# This recipe installs the packages associated with a "dispatch" Astra VM.
# This is the development environment version of this recipe.
#
# This initial implementation is a simple port of all packages from
# the dispatch-DEV bundle.  Going forward, the various Astra application
# components should be defined via their own cookbooks/recipes, while the
# open-source packages should use their standard Chef recipes.
# The recipes will then be aggregated via the AstraHub Role
# (as opposed to all of the packages being listed via this one recipe).
#
# This is all work to-be-done in future iterations.

package "erlang-otp-R15B02-sis-c6" do
   version "15.2-5.9.2"
   action :install
end

package "webmachine" do
   version "0.0.0-1.el6"
   action :install
end

package "omss-util-es6" do
   version "0.6.1-12345"
   action :install
end

package "omss-platform-dispatch-es6" do
   version "0.6.1-12345"
   action :install
end

package "omss-conf-DEV-es6" do
   version "0.6.1-12345"
   action :install
end

# This is a temporary solution to include the omss-dispatch apache
# proxyPass configuration to the aip-secweb apache server, which
# looks in different directory.
script "apache_config_dispatch" do
   interpreter    "bash"
   code  <<EOF
echo '
# Add Dispatch ProxyPass configuration to Apache config
Include /etc/httpd/conf.d/dispatch-http.conf' >> /usr/local/apache2/conf/httpd.conf
EOF
end

service "httpd" do
   action [ :restart ]
end

service "omss-dispatch" do
   action [ :enable, :restart ]
end
