Gem::Specification.new do |s|
  s.name        = 'zhjoppa'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1.1'
  s.date        = '2014-12-30'
  s.summary     = 'Captcha for Rails 4.'
  s.description = 'Captcha for Rails 4. Uses Rmagick to draw images.'
  s.authors     = ['Kanin Pavel']
  s.email       = 'kanin.pavel@gmail.com'
  s.files       = Dir["lib/**/*"] + ['Rakefile', 'README.md']
  s.test_files  = []
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/pabla/zhjoppa'
  s.license     = 'MIT'

  s.add_dependency('rails', '~> 4.1')
  s.add_dependency('rmagick', '~> 2.13')

  s.add_development_dependency('rake', '~> 10.4')
  s.add_development_dependency('minitest', '~> 5.5')
end
