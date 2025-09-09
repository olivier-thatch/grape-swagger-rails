# frozen_string_literal: true

module GrapeSwaggerRails
  class Engine < ::Rails::Engine
    paths['lib/tasks'] = 'lib/tasks/exported'

    isolate_namespace GrapeSwaggerRails

    initializer "grape_swagger_rails.assets", group: :all do |app|
      if app.config.respond_to?(:assets) && defined?(Sprockets)
        if Sprockets::VERSION.to_i >= 4
          app.config.assets.precompile << "grape_swagger_rails/application.js"
          app.config.assets.precompile << "grape_swagger_rails/application.css"
          app.config.assets.precompile << "grape_swagger_rails/favicon.ico"
        else
          # use a proc instead of a string
          app.config.assets.precompile << proc { |path| path == "grape_swagger_rails/application.js" }
          app.config.assets.precompile << proc { |path| path == "grape_swagger_rails/application.css" }
          app.config.assets.precompile << proc { |path| path == "grape_swagger_rails/favicon.ico" }
        end
      end
    end
  end
end
