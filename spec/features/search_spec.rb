require 'rails_helper'

feature 'Nerds search', type: :feature, vcr: { re_record_interval: 1.month } do
  scenario 'user finds a nerd by username and sees their language' do
    visit '/'

    fill_in 'user_name', with: 'vasiliy-pdk'
    click_on 'Search'

    expect(page).to have_text('vasiliy-pdk')
    expect(page).to have_text(/Ruby/i)
  end
end