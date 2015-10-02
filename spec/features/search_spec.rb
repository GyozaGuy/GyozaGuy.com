require 'spec_helper.rb'

feature 'Looking up posts', js: true do
  before do
    Post.create!(id: 1, title: 'Test Post 1')
    Post.create!(id: 2, title: 'Test Post 2')
    Post.create!(id: 3, title: 'Test Post 3')
    Post.create!(id: 4, title: 'Test Post 4')
  end
  scenario 'finding posts' do
    visit '/'
    fill_in 'keywords', with: 'test'
    click_on 'Search'
    
    expect(page).to have_content('Test Post 1')
    expect(page).to have_content('Test Post 2')
  end
end
