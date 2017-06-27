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
    res = Item.new.all
    puts res.inspect.class
    # 結果を表示します。
    res.each do |row|
      puts "行は#{row}"
    end
    list_req.limit.times do
      items <<  Helloworld::Item.new(id: "1", name: "name1", title: "title1", description: "deddd", price: 20, pv: 200, status: true)
    end
    return Helloworld::ListItemResponse.new(items: items, total: 2, prevPage: 3, nextPage: 4)
  end

  def get_item(get_req, _unused_call)
    item = Item.find(get_req.id.to_i)
    item.pv+1
    return Helloworld::Item.new(id: item.id, name: item.id, title: item.title, description: item.description, price: item.price, pv: item.pv, status: item.status)
  end

  def add_item(add_req, _unused_call)
    return add_req.item.save ? Helloworld::ListItemResponse.new(item: add_req.item) : nil
  end

  def update_item(update_req, _unused_call)
    i = Item.find(update_req.item.id)
    i = update_req.item
    return i.save ? Helloworld::ListItemResponse.new(item: update_req.item) : nil
  end

  def delete_item(delete_req, _unused_call)
    item = Item.find(delete_req.id.to_i)
    item.destroy
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

=begin
require 'mysql2'

# MySQL に接続します。
#my = Mysql2::Client.new('mel-exam-db', 'root', 'test456', 'mel_exam_development')
#my = Mysql2::Client.new(:socket => '/var/lib/mysql/mysql.sock', :username => 'root', :password => 'test456', :encoding => 'utf8', :database => 'mel_exam_development')


begin
  db = Mysql2::Client.new(
  :host => "mel-exam-db",
  :username => "root",
  :password => "test456",
  :database => "mel_exam_development"
  )
rescue
  host = Mysql2::Client.new(
    :host => "mel-exam-db",
    :username => "root",
    :password => "test456"
  )
  host.query("CREATE DATABASE mel_exam_development;")
end

begin
  #db.query('insert into items(id,name,title) values(1,’hei’,’title1’);')
rescue => e
  #puts "エラー#{e}"
=begin
  db.query('create table items(
  id int,
  name varchar(255),
  title varchar(255),
  description varchar(255),
  price int,
  pv int,
  status int
  );')
end

res = db.query('SELECT * FROM items')
puts res.inspect.class
# 結果を表示します。
res.each do |row|
  puts "行は#{row}"
end
=end

main
