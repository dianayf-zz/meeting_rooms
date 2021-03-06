require 'bundler'

Bundler.setup
Bundler.require :default, ENV.fetch("APP_ENV")

%W(lib config routes concepts).each do |d|
  require_all Dir.glob("#{d}/**/*.rb")
end

MeetingRoomAPI = Rack::Builder.new do
  run Routers::Root
end
