require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'multi_json'
require 'yajl/json_gem'

Bundler.require :default, ENV['RACK_ENV']
