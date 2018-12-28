#
# Cookbook:: apache9
# Recipe:: apache_install
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package node['apache9']['java_pkg'] do
    action :install
end
user node['apache9']['tomcat_user'] do
    home node['apache9']['tomcat_homedir']
    shell '/bin/false'
    action :create
end
directory node['apache9']['tomcatdir'] do
    owner node['apache9']['tomcat_user']
    group node['apache9']['tomcat_user']
    mode '0744'
    action :create
    recursive true
end
tar_extract node['apache9']['apache9_url'] do
    action :extract
    target_dir '/opt/tomcat/apache-tomcat-9.0.13'
    #creates '/opt/tomcat/apache-tomcat-9.0.14/bin'
    tar_flags [ '-P', '--strip-components 1' ]
end
link '/opt/tomcat/latest' do
    to '/opt/tomcat/apache-tomcat-9.0.13'
    link_type :symbolic
end
file '/opt/tomcat/latest/bin/*.sh' do
    mode '0744'
    action :create_if_missing
end
template node['apache9']['tomcat_servicepath'] do
    source 'tomcat.service.erb'
    owner node['apache9']['tomcat_user']
    group node['apache9']['tomcat_user']
    mode '0744'
    action :create_if_missing
end
execute 'name' do
    command 'cd /opt && sudo chown -R tomcat tomcat/'
    action :run
end
execute 'name' do
    command 'sudo systemctl daemon-reload'
    action :run
end
service node['apache9']['tomcat_user'] do
    action [:enable, :start]
end
template '/opt/tomcat/latest/conf/tomcat-users.xml' do
    source 'tomcat-users.erb'
    action :create
end
template '/opt/tomcat/latest/webapps/host-manager/META-INF/context.xml' do
    source 'context.erb'
    action :create
end
template '/opt/tomcat/latest/webapps/manager/META-INF/context.xml' do
    source 'manager_context.erb'
    action :create
end
firewall 'default' do
    action :install
end
firewall_rule 'ports' do
    protocol :tcp
    port     [80, 443, 8080, 22]
    command    :allow
end
remote_file '/opt/tomcat/latest/webapps/jenkins.war' do
    source node['apache9']['openmrs_source_path']
    action :create
end
service node['apache9']['tomcat_user'] do
    action :restart
end