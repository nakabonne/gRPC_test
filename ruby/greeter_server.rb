this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'helloworld_services_pb'
require 'item'

# GreeterServer is simple server that implements the Helloworld Greeter server.

class GreeterServer < Helloworld::API::Service
  def list_item(list_req, _unused_call)
    items = []
    all_items = Item.new.all
    list_req.limit.times do |i|
      items << Helloworld::Item.new(id: all_items[i]["id"].to_s, name: all_items[i]["name"], title: all_items[i]["title"], description: all_items[i]["description"], price: all_items[i]["price"], pv: all_items[i]["pv"], status: all_items[i]["status"])
    end
    return Helloworld::ListItemResponse.new(items: items, total: 2, prevPage: 3, nextPage: 4)
  end

  def get_item(get_req, _unused_call)
    item = Item.new.find(get_req.id.to_i)
    item.pv+1
    return Helloworld::Item.new(id: item.id, name: item.name, title: item.title, description: item.description, price: item.price, pv: item.pv, status: item.status)
  end

  def add_item(add_req, _unused_call)
    item = Item.new
    return item.save(add_req) ? Helloworld::ListItemResponse.new(item: add_req) : nil
  end

  def update_item(update_req, _unused_call)
    item = Item.new
    return item.update(update_req.item) ? Helloworld::ListItemResponse.new(item: update_req.item) : nil
  end

  def delete_item(delete_req, _unused_call)
    item = Item.new
    item.destroy(delete_req.id.to_i)
    return Helloworld::DeleteItemResponse
  end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(GreeterServer)
  s.run_till_terminated
end

main

