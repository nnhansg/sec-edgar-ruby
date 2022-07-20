# frozen_string_literal: true

require_relative "lib/sec_edgar_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "sec_edgar_ruby"
  spec.version = SecEdgarRuby::VERSION
  spec.authors = ["Nhan Nguyen"]
  spec.email = ["nnhansg@gmail.com"]

  spec.summary = "A Ruby Client for the SEC EDGAR API from sec.gov"
  spec.description = "A Ruby Client for the SEC EDGAR API from sec.gov"
  spec.homepage = "http://www.nhansg.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nnhansg/sec-edgar-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/nnhansg/sec-edgar-ruby/blob/main/CHANGELOG.md"

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'faraday'
  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
