require 'middleman-core'
require 'middleman-youtube/version'

::Middleman::Extensions.register(:youtube) do
  require 'middleman-youtube/extension'
  ::Middleman::Youtube::Extension
end
