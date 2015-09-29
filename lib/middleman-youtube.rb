# Require core library
require 'middleman-core'

# Extension namespace
class YoutubeExtension < ::Middleman::Extension
  option :width, 560, 'width of iframe'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'

    # set up your extension
    # puts options.my_option

    extension = self
    app.before_render do |body|
      extension.convert(body)
    end

  end

  def after_configuration
    # Do something
  end

  def convert(body)
    regex = %r{^\[youtube url=\"https:\/\/youtu.be\/(.*?)\"\]}
    body.gsub(regex) { iframe($1) }
  end

  def iframe(path)
    '<iframe width="' + width.to_s + '" height="' + height.to_s + '" src="https://www.youtube.com/embed/' + path + '" frameborder="0" allowfullscreen="true"></iframe>'
  end

  def width
    options[:width]
  end

  def height
    (options[:width] * (315.0 / 560.0)).round
  end

  # A Sitemap Manipulator
  # def manipulate_resource_list(resources)
  # end

  # module do
  #   def a_helper
  #   end
  # end
end

# Register extensions which can be activated
# Make sure we have the version of Middleman we expect
# Name param may be omited, it will default to underscored
# version of class name

MyExtension.register(:youtube)
