#!/usr/bin/env ruby
#
# lp.rb
# Copyright (C) 2014 BEM <brad@projectpixelpress.com>
#
# Distributed under terms of the MIT license.
#

require "lastpass.rb"
require File.expand_path(File.dirname(__FILE__))+"/configuration.rb"
require 'socket'

$userconfig=getUserConfig
$daemonconfig=getDaemonConfig

$vault_init=false

def init_vault
  unless $vault_init
  $vault_init=true
  $vault = LastPass::Vault.open_remote $userconfig['username'], $userconfig['password']
  end
end

def getByURL (url)
  init_vault
  return $vault.accounts.select{|s| s.url.include? url}
end

def getByUrlFromDaemon (url)
  host = '127.0.0.1'
  port = $daemonconfig['serverport']

  socket = UDPSocket.new
  socket.send url, 0, host, port
  response,address = socket.recvfrom(1024)
  print response         # And display it
end

begin

def startServer
  init_vault
  sock = UDPSocket.new
  sock.bind('127.0.0.1', $daemonconfig['serverport'])
  puts "Listening.."
  loop do
    packet, sender = sock.recvfrom(1500)
    response = getByURL(packet.chomp).first.password
    sock.send response, 0, sender[3], sender[1]
  end
end

if ARGV.length > 0
  urlToSearch = ARGV.first.chomp
  #puts getByURL(urlToSearch).first.password
  puts getByUrlFromDaemon(urlToSearch)
  #getByURL(urlToSearch).each{|res| print res.name," ",res.password, "\n"}
else
  startServer
end

rescue Exception => e
  puts "hahahahah: "+e.to_s
end
