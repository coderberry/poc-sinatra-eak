require 'rack'
require 'json'
require './sinatra-app/api_app'

class MyApp
  def initialize
    @app = Rack::Builder.new do
      map '/' do
        root = File.expand_path('../ember-app-kit/dist', __FILE__)
        use Rack::Static,
          :urls => Dir.glob("#{root}/*").map { |fn| fn.gsub(/#{root}/, '')},
          :root => root

        run lambda { |env|
          [ 200, { 'Content-Type'  => 'text/html',  'Cache-Control' => 'public, max-age=86400' },
            File.open("#{root}/index.html", File::RDONLY) ]
        }
      end

      map '/api' do
        run ApiApp.new
      end
    end
  end

  def call(env)
    @app.call(env)
  end
end