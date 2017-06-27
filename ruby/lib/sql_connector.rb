class SqlConnector
  require 'mysql2'
  def connect
    begin
      @db = Mysql2::Client.new(
      :host => "mel-exam-db",
      :username => "root",
      :password => "test456",
      :database => "mel_exam_development"
      )
      return @db
    rescue
      create_database #TODO 消す
    end
  end

  def create_database
    host = Mysql2::Client.new(
      :host => "mel-exam-db",
      :username => "root",
      :password => "test456"
    )
    host.query("CREATE DATABASE mel_exam_development;")
  end

  def create_table
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

  def insert()
    db.query('insert into items(id,name,title) values(1,’hei’,’title1’);')
  end
end