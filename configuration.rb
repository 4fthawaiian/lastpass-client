#!/usr/bin/env ruby
#
# configuration.rb
# Copyright (C) 2014 BEM <brad@projectpixelpress.com>
#
# Distributed under terms of the MIT license.
#



require 'parseconfig'

def getUserConfig
  return ParseConfig.new(ENV['HOME']+'/.lprc')
end
def getDaemonConfig
  return ParseConfig.new(File.expand_path(File.dirname(__FILE__))+'/lp.conf')
end
