require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

Bundler.setup
WebMock.disable_net_connect!

Dir[File.expand_path(File.join('lib', '*.rb'))].each(&method(:require))
