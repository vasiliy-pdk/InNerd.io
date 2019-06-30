require 'rails_helper'

RSpec.describe "nerds/show", type: :view do
  NerdStub = Struct.new(:login, :favourite_language)
  let(:nerd) { NerdStub.new(login: 'unclebob', favourite_language: favourite_language ) }
  let(:favourite_language) { 'javascript' }

  before do
    assign(:nerd, nerd)
    render
  end

  it 'shows the login' do
    expect(rendered).to match /unclebob/i
  end

  context 'with known favourite language' do
    it 'displays the language' do
      expect(rendered).to match /javascript/i
    end
  end

  context 'when favourite language is unknown' do
    let(:favourite_language) { nil }

    it 'tells that language is unknown' do
      expect(rendered).to match /unknown/i
    end
  end
end
