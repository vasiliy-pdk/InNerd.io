# Allows to set developer specific local environment variables in local_env.rb
Rails.application.config.before_configuration do
  env_file = File.join(Rails.root, 'config', 'local_env.yml')
  YAML.load(File.open(env_file)).each { |key, value| ENV[key.to_s] = value } if File.exists?(env_file)
end
