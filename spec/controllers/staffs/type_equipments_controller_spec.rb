require 'rails_helper'

RSpec.describe Staffs::TypeEquipmentsController, type: :controller do
  describe "GET #index" do
    before { create_list(:type_equipment, 2) }

    context 'when user authenticated' do
      sign_in_staff
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of equipment types' do
        expect(response.body).to have_json_size(2).at_path('data')
      end

      it 'returns list of equipment types json schema' do
        expect(response).to match_response_schema('type_equipments/type_equipments')
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
end
