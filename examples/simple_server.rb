#!/usr/local/bin/ruby

dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

require 'webrick'
require 'eeml'

# Create an environment object
$environment = EEML::Environment.new

# Set dummy data in environment object
$environment << EEML::Data.new(42)

# Create WEBrick server
s = WEBrick::HTTPServer.new( :Port => 50000 )

# Create a simple webrick servlet for index.eeml
class EEMLServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.status = 200
    response['Content-Type'] = "text/xml"
    response.body = $environment.to_eeml
  end
end
s.mount("/index.eeml", EEMLServlet)

# Go
trap("INT"){ s.shutdown }
s.start
