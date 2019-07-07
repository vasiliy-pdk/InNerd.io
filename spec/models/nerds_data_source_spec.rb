require 'rails_helper'

RSpec.describe NerdsDataSource, type: :model, vcr: { re_record_interval: 1.month } do
  let(:known_user) { 'vasiliy-pdk' }
  let(:non_existing_user) { 'vaaasiiiiliiiiyyy-pdk' }

  describe '.find' do
    it 'fetches user data from GitHub' do
      user_data = NerdsDataSource.find known_user

      expect(user_data).to have_attributes(login: known_user)
    end

    context 'when user is not found' do
      it 'raises an exception' do
        expect { NerdsDataSource.find non_existing_user }.to raise_exception(NerdsDataSource::NotFound)
      end
    end
  end

  describe '.primary_languages' do
    it 'returns array of languages that GitHub determined as primary language for all users` repositories' do
      languages = NerdsDataSource.primary_languages known_user

      expect(languages).to include('JavaScript', 'Ruby', nil, 'Arduino', 'C', 'CSS')
    end

    context 'when user is not found' do
      it 'raises an exception' do
        expect { NerdsDataSource.find non_existing_user }.to raise_exception(NerdsDataSource::NotFound)
      end
    end
  end
end
