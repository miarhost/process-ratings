namespace :processes do
  desc 'Start sneakers'
  task :consumer do
    on roles(:app) do
      execute "cd #{release_path} && RAILS_ENV=#{fetch(:production)} bundle exec rake sneakers:run"
    end
  end
end
