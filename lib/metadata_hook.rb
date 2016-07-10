class ElixirMetadataHook < Mumukit::Hook
  def metadata
    {language: {
        name: 'elixir',
        icon: {type: 'devicon', name: 'elixir'},
        version: '1.3.0',
        extension: 'exs',
        ace_mode: 'elixir'
    },
     test_framework: {
         name: 'exunit',
         version: '1.3.0',
         test_extension: '.exs'
     }}
  end
end