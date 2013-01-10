#
# Cookbook Name:: astra_core
# Recipe:: astra_web
#
# This recipe installs the packages associated with the "web" subtype of
# Astra VMs.  The package list matches "firstrun.web" from the current 
# sbuild.sh-based install.
# When new packages are added to this recipe, the version should
# be specified to ensure consistency across all VMs.
#
# This initial implementation is a simple port of all packages from
# firstrun.web.  Going forward, the various application components should
# be defined via their own cookbooks/recipes, while the open-source
# packages should use their standard Chef recipes.
# The various recipes will be aggregated via the AstraWeb Role (as opposed
# to all of the packages being listed via this one recipe).
#
# Also, many of these appear to be development
# packages that should not be installed onto runtime VMs.
# But for now, all are included here.
#
# This is all work to-be-done in future iterations.

package "gcc" do
   action :install
end

package "pcre" do
   action :install
end

package "make" do
   action :install
end

package "openssl-devel" do
   action :install
end

package "libxml2-devel" do
   action :install
end

package "libcurl-devel" do
   action :install
end

package "freetype-devel" do
   action :install
end

package "libpng" do
   action :install
end

package "libaio-devel" do
   action :install
end

package "cpan" do
   action :install
end

package "openldap-devel" do
   action :install
end

package "zlib" do
   action :install
end

package "byacc" do
   action :install
end

package "flex" do
   action :install
end

package "bison" do
   action :install
end

package "aip-oracle.x64_11gR2_client_pc" do
   version "2.0.0-1"
   action :install
end

package "aip-secweb" do
   version "3.0.0-6"
   action :install
end

