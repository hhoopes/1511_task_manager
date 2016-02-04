require_relative '../test_helper'

class UserCanEditAnExistingTask < FeatureTest
  def test_existing_task_is_updated_with_new_information
    task_manager.create({ title: 'Original Title',
                         description: 'Original Description' })

    id = task_manager.all.last.id
    visit "/tasks/#{id}/edit"

    fill_in 'task[title]', with: 'Updated Title'
    fill_in 'task[description]', with: 'Updated Description'
    click_button 'Submit'

    assert_equal "/tasks/#{id}", current_path
    within 'h2' do
      assert page.has_content? 'Updated Title'
    end
    within 'p' do
      assert page.has_content? 'Updated Description'
    end
  end
end
