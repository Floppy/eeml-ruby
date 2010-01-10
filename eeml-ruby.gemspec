Gem::Specification.new do |s|
  s.name = "eeml-simple"
  s.version = "0.2.0"
  s.date = "2010-01-10"
  s.summary = "A Ruby wrapper around the Extended Environments Markup Language"
  s.email = "james@floppy.org.uk"
  s.homepage = "http://github.com/Floppy/eeml-ruby"
  s.has_rdoc = true
  s.authors = ["James Smith"]
  s.files = ["README", "COPYING"]
  s.files += ["lib/eeml.rb", "lib/eeml/environment.rb", "lib/eeml/data.rb", "lib/eeml/exceptions.rb", "lib/eeml/location.rb", "lib/eeml/unit.rb"]
  s.files += ["examples/simple_server.rb"]
  s.add_dependency('builder', [">= 2.1.2"])
end
