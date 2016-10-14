class ElixirFileHook < Mumukit::Templates::FileHook
  isolated true

  def post_process_file(file, result, status)
    if /\(SyntaxError|CompileError\) tmp\/mumuki\.compile(.*)\.exs/.matches? result
      [result, :errored]
    else
      super
    end
  end

  def tempfile_extension
    '.exs'
  end
end