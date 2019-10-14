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
        expect(response).to redirect_to(:new_staff_session)
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

  describe 'POST #destroy' do
    let!(:organization) { create(:organization) }

    context 'when user authenticated' do
      sign_in_staff

      it 'returns 204 status code' do
        delete :destroy, params: { id: organization.id }
        expect(response).to have_http_status(:no_content)
      end

      it 'delete organization' do
        expect { delete :destroy, params: { id: organization.id } }.to change(Organization, :count).by(-1)
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 302 status code' do
        delete :destroy, params: { id: organization.id }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'GET #show' do
    let!(:organization) { create(:organization) }

    context 'when user authenticated' do
      sign_in_staff

      before { get :show, params: { id: organization.id, format: :json } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns organization json schema' do
        expect(response).to match_response_schema('organizations/organization')
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        get :show, params: { id: organization.id, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:organization) { create(:organization) }
    let(:update_params) do
      {
        name: 'Updated Company Ltd.',
        kind: 'ЮЛ',
        inn: 1_222_333_44,
        ogrn: 11_333_555_777
      }
    end

    context 'when user authenticated' do
      sign_in_staff

      before { patch :update, params: { id: organization.id, organization: update_params, format: :json } }

      context 'with valid attributes' do
        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        %i[name kind inn ogrn].each do |attr|
          it "change organization :#{attr} attribute" do
            expect(organization.reload.send(attr)).to eq update_params[attr]
          end
        end

        it 'returns organization json schema' do
          expect(response).to match_response_schema('organizations/organization')
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) { attributes_for(:invalid_organization) }

        before { patch :update, params: { id: organization.id, organization: invalid_params, format: :json } }

        it 'returns 422 status code' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        %i[name kind inn ogrn].each do |attr|
          it "does not change organization :#{attr} attribute" do
            expect(organization.reload.send(attr)).not_to eq invalid_params[attr]
          end
        end
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        patch :update, params: { id: organization.id, organization: update_params, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
