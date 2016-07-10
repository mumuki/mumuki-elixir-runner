require 'mumukit'

Mumukit.runner_name = 'elixir'
Mumukit.configure do |config|
  config.docker_image = 'elixij'
end

require_relative 'test_hook'
require_relative 'metadata_hook'


