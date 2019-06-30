require 'rails_helper'

RSpec.describe NerdsController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    describe 'flash messages' do
      render_views

      it 'shows flash messages if any' do
        get :index, { flash: { one: 'Flash 1', two: 'Flash 2' } }

        expect(response.body).to include('Flash 1', 'Flash 2')
      end
    end
  end

  describe 'GET #search' do
    it 'redirects to #show with given username' do
      get :search, params: { user_name: 'MikeCohn' }

      expect(response).to redirect_to(nerd_path('MikeCohn'))
    end

    context 'when searched with empty user_name' do
      it 'reminds to add search term' do
        get :search, params: { user_name: '' }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/Please enter GitHub username to the search field/i)
      end
    end
  end

  describe 'GET #show' do
    context 'when nerd is found' do
      let(:found_nerd) { double 'nerd' }

      before do
        allow(Nerd).to receive(:find).with('KentBeck').and_return found_nerd

        get :show, params: { id: 'KentBeck' }
      end

      it 'assigns found nerd to the template' do
        expect(assigns(:nerd)).to be(found_nerd)
      end

      it 'renders show view' do
        expect(response).to render_template(:show)
      end
    end

    context 'when nerd was not found' do
      it 'redirects to search page with a polite notice' do
        allow(Nerd).to receive(:find).and_raise NerdsDataSource::NotFound
        non_existing_nerd = 'non_existing_nerd'
        get :show, params: { id: non_existing_nerd }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/no GitHub account with name "#{non_existing_nerd}"/i)
      end
    end
  end
end
