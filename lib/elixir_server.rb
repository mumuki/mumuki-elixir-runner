require 'mumukit'

Mumukit.configure do |config|
  config.docker_image = 'elixir'
  config.runner_name = 'elixir-server'
end

require_relative './metadata_hook'
require_relative './test_hook'
