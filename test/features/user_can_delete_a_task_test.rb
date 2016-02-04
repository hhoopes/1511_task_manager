require_relative '../test_helper'

class UserCanDeleteAnExistingTask < FeatureTest
  def test_existing_task_is_deleted_successfully
    task_manager.create({ 
      title: 'Original Title',
      description: 'Original Description' 
    })

    visit '/tasks'

    assert page.has_content? 'Original Title'

    click_button 'Delete'

    within '#tasks' do
      refute page.has_content? 'Original Title'
    end
  end
end
