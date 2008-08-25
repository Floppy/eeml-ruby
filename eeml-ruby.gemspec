Gem::Specification.new do |s|
  s.name = "eeml"
  s.version = "0.0.2"
  s.date = "2008-08-25"
  s.summary = "A Ruby wrapper around the Extended Environments Markup Language"
  s.email = "james@floppy.org.uk"
  s.homepage = "http://github.com/Floppy/eeml-ruby"
  s.has_rdoc = true
  s.authors = ["James Smith"]
  s.files = ["README", "COPYING"]
  s.files += ["lib/eeml.rb", "lib/eeml/environment.rb", "lib/eeml/data.rb", "lib/eeml/exceptions.rb"]
  s.files += ["examples/simple_server.rb"]
end