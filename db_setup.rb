require 'mysql2'

def connect
  db = Mysql2::Client.new(
  :host => "mel-exam-db",
  :username => "root",
  :password => "test456",
  :database => "mel_exam_development"
  )
  db
end

def create_database
  host = Mysql2::Client.new(
    :host => "mel-exam-db",
    :username => "root",
    :password => "test456"
  )
  host.query("CREATE DATABASE mel_exam_development;")
end

def create_table(con)
  con.query('create table items(
  id int,
  name varchar(255),
  title varchar(255),
  description varchar(255),
  price int,
  pv int,
  status int,
  PRIMARY KEY (`id`)
  )
  ENGINE=InnoDB DEFAULT CHARSET=utf8')
end

def insert(con)
  5.times do |i|
    con.query("insert into items(id,name,title,description,price,pv,status) values(#{i},'name#{i}','title#{i}','status#{i}','price#{i}','pv#{i}','status#{i}');")
  end
end

#create_database
con = connect
create_table(con)
insert(con)