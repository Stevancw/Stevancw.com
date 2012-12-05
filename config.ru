require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)


gem 'rack-rewrite', '~> 1.3.1'
require 'rack-rewrite'
    if ENV['RACK_ENV'] == 'production'
        use Rack::Rewrite do
         r301 %r{.*}, 'http://stevancw.com$&', :if => Proc.new {|rack_env|
        rack_env['SERVER_NAME'] != 'stevancw.com'
        }
    end
end

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'
run Nesta::App