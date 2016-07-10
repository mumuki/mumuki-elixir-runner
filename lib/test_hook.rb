class ElixirTestHook < Mumukit::Templates::FileHook
  isolated true

  def compile_file_content(request)
<<elixir
#{request.extra}
#{request.content}

ExUnit.start
defmodule AssertionTest do
  use ExUnit.Case, async: true
#{request.test}
end
elixir
  end

  def tempfile_extension
    '.exs'
  end

  def command_line(filename)
    "elixir #{filename}"
  end

  def format_code(code)
    "```\n#{code}\n```"
  end

  def post_process_file(file, result, status)
    [format_code(result), status]
  end

end
