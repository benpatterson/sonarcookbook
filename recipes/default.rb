#
# Cookbook Name:: sonartest
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

mysql_connection_info = {:host => "localhost",
                         :username => 'debian-sys-maint',
                         :password => node['mysql']['server_debian_password']}

apt_repository "sonar" do
    uri "http://downloads.sourceforge.net/project/sonar-pkg/deb binary/"
  action :add
end

package "sonar" do
     options "--force-yes"
  action :install
end

template "sonar.properties" do
  source "sonar.properties.erb"
  path "/opt/sonar/conf/sonar.properties"
end

mysql_database 'sonar' do
  connection mysql_connection_info
sql "CREATE USER 'sonar' IDENTIFIED BY 'sonar';
GRANT ALL ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar';
GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar';
FLUSH PRIVILEGES;"
# yeah  action :create
  action :query
end


