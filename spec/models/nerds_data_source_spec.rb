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

      expect(languages).to include('JavaScript', 'Ruby', 'Arduino')
    end

    context 'when user is not found' do
      it 'raises an exception' do
        expect { NerdsDataSource.find non_existing_user }.to raise_exception(NerdsDataSource::NotFound)
      end
    end

    it 'does not return forks' do
      own_repository = repository_double({ name: 'Foo', fork: false, language: 'Ruby' })
      fork_repository = repository_double({ name: 'Microsoft Calculator', fork: true, language: 'C#' })

      allow_any_instance_of(Octokit::Client).to receive(:repositories).and_return [own_repository, fork_repository]

      expect(NerdsDataSource.primary_languages known_user).to eq(['Ruby'])
    end
  end

  describe '.own_repositories' do
    it 'excludes forks' do
      own_repositories = [
        repository_double({ name: 'Foo', fork: false }),
        repository_double({ name: 'Bar', fork: false })
      ]
      fork_repository = repository_double({ name: 'Microsoft Calculator', fork: true })
      all_repositories = own_repositories + [fork_repository]

      allow_any_instance_of(Octokit::Client).to receive(:repositories).and_return all_repositories

      expect(NerdsDataSource.own_repositories(known_user)).to include(*own_repositories)
      expect(NerdsDataSource.own_repositories(known_user)).not_to include(fork_repository)
    end
  end

  def repository_double(attributes)
    OpenStruct.new(attributes)
  end
end
