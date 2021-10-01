require 'bundler'
require 'warning'

Gem.path.each do |path|
  Warning.ignore(//, path)
end
Bundler.setup

Bundler.require :default, ENV.fetch("APP_ENV")


%W(lib config routes concepts).each do |d|
  require_all Dir.glob("#{d}/**/*.rb")
end

Hanami::Model.load!

MeetingRoomAPI = Rack::Builder.new do
  run Routers::Root
end
