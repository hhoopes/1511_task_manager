require_relative '../test_helper'

class UserCanCreateANewTask < FeatureTest
  def test_task_creation_with_valid_attributes
    visit '/tasks/new'

    fill_in 'task[title]', with: 'Example Task'
    fill_in 'task[description]', with: 'Example Description'
    click_button 'Submit'

    assert_equal '/tasks', current_path

    within '#tasks' do
      assert page.has_content? 'Example Task'
    end
  end
end
