require 'middleman-core/logger'

module Middleman
  module Youtube
    class Extension < ::Middleman::Extension
      option :width, 560, 'width of iframe'

      def initialize(app, options_hash = {}, &block)
        super
        extension = self
        @app = app
        app.after_render do |body|
          extension.convert(body)
        end
      end

      # def after_configuration
      # end

      def logger
        ::Middleman::Logger.singleton
      end

      def convert(body)
        logger.debug body
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
    end
  end
end
