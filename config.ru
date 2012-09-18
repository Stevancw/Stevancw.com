require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'rack-rewrite'
if ENV['RACK_ENV'] == 'production'
  use Rack::Rewrite do
    r301 %r{.*}, 'http://stevancw.com$&', :if => Proc.new  do |rack_env|
      rack_env['SERVER_NAME'] != 'stevancw.com'
    end
  end
end


require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'
run Nesta::App