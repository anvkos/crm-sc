require 'rails_helper'

RSpec.describe Staffs::ClientsOrganizationsController, type: :controller do
  describe 'POST #add_client' do
    let!(:organization) { create(:organization) }
    let!(:client) { create(:client) }
    let(:params) do
      {
        id: organization.id,
        organization: {
          client_id: client.id
        },
        format: :json
      }
    end

    context 'when user authenticated' do
      sign_in_staff

      context 'with valid attributes' do
        it 'returns 200 status code' do
          post :add_client, params: params
          expect(response).to have_http_status(:ok)
        end

        it 'saves client_organization in the database' do
          expect do
            post :add_client, params: params
          end.to change(organization.clients, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            id: organization.id,
            organization: {
              client_id: nil
            },
            format: :json
          }
        end

        it 'returns 404 status code' do
          post :add_client, params: invalid_params
          expect(response).to have_http_status(:not_found)
        end

        it 'does not save client_organization in the database' do
          expect { post :add_client, params: invalid_params }.not_to change(organization.clients, :count)
        end
      end
    end
  end
end
