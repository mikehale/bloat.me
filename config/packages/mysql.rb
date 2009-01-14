package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w(mysql-server mysql-client)
  requires :mysql_driver
end

package :mysql_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  requires :libmysqlclientdev
end

package :libmysqlclientdev do
  description 'MySQL database development files'
  apt 'libmysqlclient15-dev'
end
