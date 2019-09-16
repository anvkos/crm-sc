require 'rails_helper'

RSpec.describe Staffs::ClientsController, type: :controller do

  describe "GET #index" do
    before { create_list(:client, 2) }

    context 'when user authenticated' do
      sign_in_staff
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of clients' do
        expect(response.body).to have_json_size(2).at_path('data')
      end

      it 'returns clients json schema' do
        expect(response).to match_response_schema('clients/clients')
      end
    end

  end

end
