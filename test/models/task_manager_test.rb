require_relative "../test_helper"

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def create_tasks(num)
    num.times do |i|
      task_manager.create(
        title:       "title#{i+1}",
        description: "description#{i+1}"
      )
    end
  end

  def test_can_create_a_task
    task_manager.create(
      title:       "title1",
      description: "description1"
    )

    task = task_manager.all.last
    assert task.id
    assert_equal "title1", task.title
    assert_equal "description1", task.description
  end

  def test_it_finds_all_tasks
    create_tasks(3)

    assert_equal 3, task_manager.all.count

    task_manager.all.each_with_index do |task, index|
      assert_equal Task, task.class
      assert_equal "title#{index+1}", task.title
      assert_equal "description#{index+1}", task.description
    end
  end

  def test_it_finds_a_specific_task
    create_tasks(3)
    ids = task_manager.all.map { |task| task.id }

    ids.each_with_index do |id, index|
      task = task_manager.find(id)
      assert_equal id, task.id
      assert_equal "title#{index+1}", task.title
      assert_equal "description#{index+1}", task.description
    end
  end

  def test_it_updates_a_task_record
    create_tasks(2)

    new_data = {
      :title => "NEW title",
      :description => "NEW description"
    }
    id = task_manager.all.last.id
    task_manager.update(new_data, id)

    updated_task = task_manager.find(id)

    assert_equal new_data[:title], updated_task.title
    assert_equal new_data[:description], updated_task.description
  end

  def test_it_deletes_a_task_record
    create_tasks(3)

    initial_count = task_manager.all.count
    id = task_manager.all.last.id
    task_manager.delete(id)

    final_count = task_manager.all.count

    assert_equal 1, (initial_count - final_count)
  end
end
