$:.unshift File.dirname(__FILE__)

# stdlib
require 'erb'

# 3rd party
require 'trollop'
require 'rest_connection'

# internal requires
require 'haproxy/config'
require 'frontends/rightscale'
