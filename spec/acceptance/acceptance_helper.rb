require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'


RSpec.configure do |config|
  config.include Capybara
end

require File.expand_path '../../../app.rb', __FILE__

Capybara.app = Sinatra::Application
