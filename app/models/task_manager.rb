class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.from(:tasks).insert(task)
  end

  def all
     database.from(:tasks).to_a.map {|data| Task.new(data)}
  end

  def find(id)
    result = database.from(:tasks).where(:id => id).to_a.first
    Task.new(result)
  end

  def update(task, id)
    database.from(:tasks).where(:id => id).update(:title => task[:title], :description => task[:description])
  end

  def delete(id)
    database.from(:tasks).where(:id => id).delete
  end
end
