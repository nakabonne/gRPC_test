class Item < SqlConnector
  def initialize
    connect
  end
  def all
    @db.query('SELECT * FROM items')
  end
end