# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :application, "blog_app"
set :repo_url, "https://github.com/Shoko-Kikuchi/aws_task.git"
set :linked_files, %w{config/secrets.yml}   # 4
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}   
set :linked_files, %w{config/secrets.yml .env} # 5
set :keep_releases, 5   # 6
set :rbenv_ruby, '3.3.0'    # 7
set :log_level, :info   # 8

after 'deploy:published', 'deploy:seed'   # 9
after 'deploy:finished', 'deploy:restart'   # 10

namespace :deploy do
  desc 'Run seed'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end