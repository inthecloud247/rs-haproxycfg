$:.unshift File.dirname(__FILE__)

# stdlib
require 'erb'

# 3rd party
require "bundler/setup"
Bundler.require(:default)

# internal requires
require 'haproxy/config'
require 'frontends/rightscale'
