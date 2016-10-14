require 'mumukit'

Mumukit.runner_name = 'elixir'
Mumukit.configure do |config|
  config.docker_image = 'mumuki/mumuki-elixir-worker'
  config.comment_type = Mumukit::Directives::CommentType::Ruby
  config.stateful = true
end

require_relative './elixir_file_hook'
require_relative './test_hook'
require_relative './metadata_hook'
require_relative './query_hook'
