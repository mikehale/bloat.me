#!/usr/bin/env sprinkle -s

$LOAD_PATH << File.dirname(__FILE__)

require 'build_essential'
require 'ruby_enterprise_edition'
require 'passenger'
require 'apache'
require 'mysql'
require 'postfix'

policy :singleserver, :roles => :app do
  requires :ruby1_8_6
  requires :webserver
  requires :appserver
  requires :database
  requires :mailserver
end

deployment do
  delivery :capistrano do
    recipes 'config/deploy.rb'
    recipes 'config/deploy/production.rb'
  end

  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end