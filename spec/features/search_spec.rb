require 'rails_helper'

feature 'Nerds search', type: :feature do
  scenario 'user finds a nerd' do
    visit '/'

    fill_in 'user_name', with: 'vasiliy-pdk'
    click_on 'Search'

    expect(page).to have_text('Vasyl Pedak')
  end
end