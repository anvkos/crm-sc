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

  describe 'POST #create' do
    let(:params) do
      {
        fullname: 'full_name',
        email: 'test@test.com',
        phone: 7_888_999_77_89,
        format: :json
      }
    end

    context 'when user authenticated' do
      sign_in_staff

      context 'with valid attributes' do
        it 'returns 201 status code' do
          post :create, params: params
          expect(response).to have_http_status(:created)
        end

        it 'returns client json schema' do
          post :create, params: params
          expect(response).to match_response_schema('clients/client')
        end

        it 'saves new client in the database' do
          expect { post :create, params: params }.to change(Client, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            fullname: nil,
            email: nil,
            phone: nil,
            format: :json
          }
        end

        it 'returns 422 status code' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the client in the database' do
          expect { post :create, params: invalid_params }.not_to change(Client, :count)
        end
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        post :create, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
