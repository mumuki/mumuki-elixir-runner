class ElixirQueryHook < Mumukit::Templates::FileHook
  isolated true

  def tempfile_extension
    '.exs'
  end


  def compile_file_content(r)
   <<elixir
defmodule ElixirServer do

  try do
    #{r.extra}
    #{r.content}
    #{compile_cookie(r.cookie)}
    #{compile_query(r.query)}
  catch
    _ -> IO.puts ""
  end
end
elixir
  end

  def compile_query(query)
    if query.start_with? 'def '
      "#{query}\nIO.puts \"<function>\""
    else
      "IO.inspect #{query}"
    end
  end

  def compile_cookie(cookie)
    return if cookie.blank?
    cookie.join("\n")
  end

  def command_line(filename)
    "elixir #{filename}"
  end
end