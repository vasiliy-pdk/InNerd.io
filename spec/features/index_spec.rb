require 'rails_helper'

RSpec.feature "Index", type: :feature do
  it 'works' do
    visit '/'

    expect(page).to have_text(/InNerd/i)
  end
end
