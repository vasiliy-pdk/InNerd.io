require 'rails_helper'

feature 'Nerds search', type: :feature do
  scenario 'user finds a nerd by username and sees their language' do
    visit '/'

    fill_in 'user_name', with: 'vasiliy-pdk'
    click_on 'Search'

    expect(page).to have_text('vasiliy-pdk')
    expect(page).to have_text(/javascript/i)
  end
end
