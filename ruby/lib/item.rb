class Item
  def initialize
    connect
  end

  def all
    @db.query('SELECT * FROM items') rescue false
  end

  def find(id)
    @db.query("SELECT * FROM items WHERE id = #{id}") rescue false
  end

  def save(item)
    @db.query("insert into items(id,name,title,description,price,pv,status) values(#{item.id.to_i},#{item.name},#{item.title},#{item.description},#{item.price},#{item.pv},#{item.status});") rescue false
  end

  def update(item)
    @db.query("UPDATE items SET name = #{item.name}, title = #{item.title}, description = #{item.description}, price = #{item.price}, pv = #{item.pv}, status = #{item.status} WHERE id = #{item.id.to_i};") rescue false
  end

  def destroy(id)
    @db.query("DELETE FROM items WHERE id = #{id};") rescue false
  end

  def connect
    @db = Mysql2::Client.new(
    :host => "mel-exam-db",
    :username => "root",
    :password => "test456",
    :database => "mel_exam_development"
    )
  end
end

