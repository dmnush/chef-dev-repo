#
# Cookbook Name:: astra_core
# Recipe:: astra_logins
#
# This recipe manages Astra user logins and groups.
# Each user must be defined in the data bag 'astra_logins', and groups
# in the data bag 'astra_groups'.
#
# Each element of the astra_logins data bag should have the attributes:
# id  (the login id)
# uid  (numeric user id)
# gid  (numeric group id)
# shell  (login shell)
# comment  (login name)
# envs  (array of environments, e.g. ["dev", "itl"])
# groups  (array of secondary groups for the user, e.g. ["omss"])
#
# Each element of the astra_groups data bag should have the attributes:
# id  (the group name)
# gid  (numeric group id)
# envs  (array of environments, e.g. ["dev", "itl"])
# 
# Copyright 2012, AT&T
# All rights reserved - Do Not Redistribute
#

# Get the current environment for context
env = node.chef_environment

# Hard-code 'omss' and 'sis' groups and users.
# They're needed as system logins on every VM.
#
group "omss" do
   action   :create
   gid      501
end

user "omss" do
   action   :create
   uid       501
   gid       "omss"
   comment   "OMSS System Login"
   supports  :manage_home => false
end

group "sis" do
   action   :create
   gid      502
end

user "sis" do
   action   :create
   uid       502
   gid       "sis"
   comment   "SIS System Login"
   home      "/home/sis"
   supports  :manage_home => true
end

# Set up omss logging dir
directory "/var/log/omss" do
   action  :create
   owner   "omss"
   group   "omss"
   mode    00755
end

# Set up special python links for omss & sis repos
link "/usr/local/bin/python-omss" do
   action     "create"
   to         "/usr/bin/python2.6"
   link_type  :symbolic
end

link "/usr/lib/python2.6/site-packages/sis" do
   action     "create"
   to         "/usr/local/lib/python2.6/site-packages/sis"
   link_type  :symbolic
end

# What Chris does now...  should be more secure
script "omss_sudoers" do
   interpreter  'bash'
   code         'echo "%omss	ALL=(ALL)	ALL"  >> /etc/sudoers'
end

# Load groups from the 'astra_groups' data bag
groups = data_bag('astra_groups')
groups.each do |groupname|
   grp = data_bag_item('astra_groups',groupname)
   
   if (grp['envs'].include? env) || (grp['envs'].include? "ALL")
      group groupname do
         action   :create
         gid      grp['gid']
      end
   else 
      # Delete groups not in current environment
      group groupname do
         action    :remove
      end
   end
end

# Load the login IDs from the astra_logins data bag
logins = data_bag('astra_logins')

logins.each do |login|
   data = data_bag_item('astra_logins', login)
   home = "/home/#{login}"

   curuser = system("grep -qs #{login} /etc/passwd")

   if (data['envs'].include? env) || (data['envs'].include? "ALL")
      user login do
         action    :create
         uid       data['uid']
         gid       data['gid']
         shell     data['shell']
         comment   data['comment']
         home      home
         supports  :manage_home => true
      end

      # Add the user to its secondary groups.  Take no action if the
      # group does not exist (action :manage)
      data['groups'].each do |grp|
         group grp do
            action    :manage
            members   login
            append    true
         end
      end

      # For new users, set the default password
      if ! curuser
         script "default_password" do
            interpreter  "bash"
            code         <<-EOH
               echo 'ChangeMeRightNow!' | (passwd --stdin #{login})
               chage -d 0  #{login}
            EOH
         end
      end
   else 
      # Delete users not in current environment
      user login do
         action    :remove
      end
   end
end

# Make sure this recipe is in cron.  Update the logins every 12 hours.
cron "login_check" do
   hour      "0,12"
   minute    "0"
   command   "chef-client -o 'recipe[astra_core::astra_logins]'"
end
