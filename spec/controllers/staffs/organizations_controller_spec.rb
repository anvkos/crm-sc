require 'rails_helper'

RSpec.describe Staffs::OrganizationsController, type: :controller do
  describe "GET #index" do
    before { create_list(:organization, 2) }

    context 'when user authenticated' do
      sign_in_staff
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of organizations' do
        expect(response.body).to have_json_size(2).at_path('data')
      end

      it 'returns organizations json schema' do
        expect(response).to match_response_schema('organizations/organizations')
      end
    end

    context 'when user is not unauthorized' do
      before { get :index }

      it 'returns 302 status code' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to signin' do
        expect(response).to redirect_to(:new_staffs_staff_session)
      end
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        organization: {
          name: 'Company Ltd.',
          kind: 'test@test.com',
          inn: 7_789_222_111,
          ogrn: 77_555_333_222_111
        },
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

        it 'returns organization json schema' do
          post :create, params: params
          expect(response).to match_response_schema('organizations/organization')
        end

        it 'saves new organization in the database' do
          expect { post :create, params: params }.to change(Organization, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            organization: attributes_for(:invalid_organization),
            format: :json
          }
        end

        it 'returns 422 status code' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the organization in the database' do
          expect { post :create, params: invalid_params }.not_to change(Organization, :count)
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
