#
# Cookbook Name:: openam
# Recipe:: default
#
# Copyright 2013, AT&T
#
# All rights reserved - Do Not Redistribute
#

package "openam" do
   version "10.0.1-1"
   action :install
end

command "chown tomcat:tomcat /opt/forgerock/opensso"
	"cp /opt/forgerock/opensso/deployable-war/opensso.war /usr/share/tomcat6/webapps/access.war"
	"mkdir /opt/forgerock/OpenAM"
	"chown tomcat:tomcat /opt/forgerock/OpenAM"
	"iptables -t mangle -A PREROUTING -p tcp -m tcp --dport 80 -j MARK --set-xmark 0x64/0xffffffff"
	"iptables -t filter -A INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -m mark --mark 0x64 -j ACCEPT"
end

template "/usr/share/tomcat6/webapps/access.war" do
	notifies :restart, resources(:service => "tomcat")
end
