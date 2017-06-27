#!/usr/bin/env ruby

# Copyright 2015, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Sample app that connects to a Greeter service.
#
# Usage: $ path/to/greeter_client.rb

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'helloworld_services_pb'
require 'item'

def stub
  Helloworld::API::Stub.new('localhost:50051', :this_channel_is_insecure)
end
def list_item(page, limit)
  list_item = stub.list_item(Helloworld::ListItemRequest.new(page: page.to_i, limit: limit.to_i)).items
  p "ListItem: #{list_item}"
end
def get_item(id)
  get_item = stub.get_item(Helloworld::GetItemRequest.new(id: id.to_i))
  p "GetItem: #{get_item}"
end
def add_item(item)
  add_item = stub.add_item(Helloworld::Item.new(id: item.id, name: item.id, title: item.title, description: item.description, price: item.price, pv: item.pv, status: item.status)).item
  p "AddItem: #{add_item}"
end
def update_item(item)
  update_item = stub.update_item(Helloworld::UpdateItemRequest.new(item: item)).item
  p "UpdateItem: #{update_item}"
end
def delete_item(id)
  delete_item = stub.delete_item(Helloworld::DeleteItemRequest.new(id: id.to_i))
  p "DeleteItem: #{delete_item}"
end

def excution
  puts "入力して下さい"
  puts "1 => ListItem\n2 => GetItem\n3 => AddItem\n4 => UpdateItem\n5 => DeleteItem"
  case gets.chomp
  when "1"
    puts "pageを入力して下さい"
    page = gets.chomp
    puts "limitを入力して下さい"
    limit = gets.chomp
    list_item(page, limit)
  when "2"
    puts "idを入力して下さい"
    id = gets.chomp
    get_item(id)
  when "3"
    add_item
  when "4"
    update_item
  when "5"
    puts "idを入力して下さい"
    id = gets.chomp
    delete_item(id)
  else
    puts "値が不正です。1~5のいずれかを入力して下さい"
  end
  excution
end

excution
