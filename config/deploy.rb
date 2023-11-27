
lock '~> 3.17.3'

set :application, 'process-ratings'
set :repo_url, 'git@github.com:miarhost/process-ratings.git'
set :use_sudo, true
set :branch, 'main'
set :user, 'ec2-user'

set :linked_files, %w{config/database.yml config/master.key .env docker-compose.yml Dockerfile Gemfile Gemfile.lock }

set :all_roles, %i[app worker db]

namespace :deploy do
  task :cleanup_orphaned_containers do
    on roles(:app) do
      within release_path do
        execute("cd #{release_path} && docker system prune -a -f --volumes")
      end
    end
  end

  task :run_composer do
    on roles(:app) do
      within release_path do
        execute("cd #{release_path} && docker-compose -f /var/www/sharcst/process-ratings/shared/docker-compose.yml down")
        execute("cd #{release_path} && docker-compose -f /var/www/sharcst/process-ratings/shared/docker-compose.yml up -d")
      end
    end
  end
end

set :upload_roles, %i[app worker db]

append :linked_dirs, 'tmp/pids', 'tmp/sockets', 'public'

set :keep_releases, 2

set :connection_timeout, 5
before "deploy:starting", "deploy:cleanup"

before 'deploy:check', 'linked_files:upload'

after 'deploy:updated', 'deploy:cleanup_orphaned_containers'
after 'deploy:cleanup_orphaned_containers', 'deploy:run_composer'
