require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/linked_files'

install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
Rake::Task["bundler:install"].clear
