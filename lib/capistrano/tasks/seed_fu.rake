namespace :seed_fu do
  task :apply do
    if fetch(:rails_env) == :staging
      on roles(:db) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle,
                    :exec,
                    'rails db:seed_fu'
          end
        end
      end
    end
  end
end
