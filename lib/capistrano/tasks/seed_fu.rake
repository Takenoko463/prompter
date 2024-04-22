namespace :deploy do
  desc 'Run seed_fu'
  task :seed_fu do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, 'rake db:seed_fu'
        end
      end
    end
  end
end

after 'deploy:migrate', 'deploy:seed_fu'
