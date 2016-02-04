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

  def raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def find(id)
    result = database.from(:tasks).where(:id => id).to_a.first
    Task.new(result)
  end

  def update(task, id)
    result = database.from(:tasks).where(:id => id).update(:title => task[:title], :description => task[:description])
    # database.transaction do
    #   target_task = database["tasks"].find { |task| task["id"] == id }
    #
    #   target_task["title"]       = task[:title]
    #   target_task["description"] = task[:description]
    # end
  end

  def delete(id)
    database.from(:tasks).where(:id => id).delete
  end

  def delete_all
    database.transaction do
      database['tasks'] = []
      database['total'] = 0
    end
  end
end
