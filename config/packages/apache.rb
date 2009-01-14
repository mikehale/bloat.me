package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    %w(deflate rewrite expires).each{|mod|
      post :install, "a2enmod #{mod}"
    }
  end

  verify do
    has_file '/usr/sbin/apache2ctl'
  end
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end