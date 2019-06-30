require 'rails_helper'

NerdData = Struct.new(:login)

RSpec.describe Nerd, type: :model do
  describe '.find' do
    it 'returns an instance of found Nerd' do
      expected_login = 'martinfowler'
      allow(NerdsDataSource).to receive(:find).with(expected_login)
                                  .and_return NerdData.new(expected_login)

      martin = Nerd.find expected_login

      expect(martin).to be_a(Nerd)
      expect(martin.login).to eq(expected_login)
    end

    context 'when nerd was not found' do
      it 'returns nil' do
        allow(NerdsDataSource).to receive(:find).and_return nil

        expect(Nerd.find 'john_snow').to be_nil
      end
    end
  end

  describe '#favourite_language' do
    describe 'guesses favourite programming language' do
      context 'with just one result' do
        it 'returns language name' do
          nerd = nerd_with_languages ['ruby']

          expect(nerd.favourite_language).to eq('ruby')
        end
      end

      context 'with many results' do
        it 'returns most frequently used language' do
          nerd = nerd_with_languages ['python', 'ruby', 'ruby', 'c++']

          expect(nerd.favourite_language).to eq('ruby')
        end

        it 'returns first of equally used languages' do
          nerd = nerd_with_languages ['python', 'ruby', 'ruby', 'python']

          expect(nerd.favourite_language).to eq('python')
        end
      end

      context 'when there are undetermined languages among others' do
        it 'guesses from determined ones only' do
          nerd = nerd_with_languages [nil, 'ruby', nil]

          expect(nerd.favourite_language).to eq('ruby')
        end
      end

      context 'when there are no determined languages at all' do
        it 'returns nil' do
          nerd = nerd_with_languages [nil, nil]
          expect(nerd.favourite_language).to be_nil

          jim = nerd_with_languages [nil], 'jim'
          expect(jim.favourite_language).to be_nil

          suzy = nerd_with_languages [], 'suzy'
          expect(suzy.favourite_language).to be_nil
        end
      end
    end

    def nerd_with_languages(languages, nerd_login = 'lora')
      allow(NerdsDataSource).to receive(:primary_languages).with(nerd_login).and_return languages
      Nerd.new nerd_login
    end
  end
end
