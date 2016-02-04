ENV["RACK_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'

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
    database = Sequel.sqlite("db/task_manager_test.sqlite3")
    @task_manager ||= TaskManager.new(database)
  end
end

DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/task_manager_test.sqlite3")}].strategy = :truncation

Capybara.app = TaskManagerApp
Capybara.save_and_open_page_path = 'tmp/capybara'

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
