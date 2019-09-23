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
end
