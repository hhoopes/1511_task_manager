Get started:

* Sequel.sqlite("db/task_manager_test.sqlite3")
* Sequel.sqlite("db/task_manager_dev.sqlite3")


```ruby
DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/task_manager_test.sqlite3")}].strategy = :truncation

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end
  
  def task_manager
    database = YAML::Store.new('db/task_manager_test')
    @task_manager ||= TaskManager.new(database)
  end
end
```