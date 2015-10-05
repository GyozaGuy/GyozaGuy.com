require 'spec_helper.rb'

feature 'Viewing a post', js: true do
  before do
    Post.create!(title: 'Test Post 1', content: 'This is a test of the emergency alert system.')
    Post.create!(title: 'Test Post 2', content: 'This is yet another test.')
  end
  scenario 'view one post' do
    visit '/'
    fill_in 'keywords', with: 'test'
    click_on 'Search'

    click_on 'Test Post 2'

    expect(page).to have_content('Test Post 2')
    expect(page).to have_content('yet another')

    click_on 'Back'

    expect(page).to have_content('Test Post 2')
    expect(page).to_not have_content('yet another')
  end
end
