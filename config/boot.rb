require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'yajl/json_gem'

Bundler.require :default, ENV['RACK_ENV']
