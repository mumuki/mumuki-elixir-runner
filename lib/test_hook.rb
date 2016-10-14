class ElixirTestHook < ElixirFileHook
  def compile_file_content(request)
<<elixir
ExUnit.start
defmodule ElixirServer do
  #{request.extra}
  #{request.content}
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

end
