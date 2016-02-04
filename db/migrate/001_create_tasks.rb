require 'sequel'

if ENV["RACK_ENV"] == "test"
  database = Sequel.sqlite("db/task_manager_test.sqlite3")
else
  database = Sequel.sqlite("db/task_manager_dev.sqlite3")
end

database.create_table(:tasks) do
  primary_key :id
  String :title
  String :description
end
