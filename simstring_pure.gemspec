Gem::Specification.new do |s|
  s.name        = 'simstring_pure'
  s.version     = '1.1.0'
  s.date        = '2016-03-08'
  s.summary     = "SimString approximate string matching library."
  s.description = "A Ruby implementation of the SimString approximate string matching algorithm."
  s.authors     = ["David Ellis"]
  s.email       = "davidkellis@gmail.com"
  s.files       = ["lib/simstring_pure.rb"]
  s.homepage    = "https://github.com/davidkellis/simstring"
  s.license     = "MIT"

  s.executables << "simstring"
end
