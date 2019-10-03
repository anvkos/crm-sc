require 'rails_helper'

RSpec.describe Staffs::EquipmentController, type: :controller do
  describe "GET #index" do
    before { create_list(:equipment, 2) }

    context 'when user authenticated' do
      sign_in_staff
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of equipment' do
        expect(response.body).to have_json_size(2).at_path('data')
      end

      it 'returns list of equipment json schema' do
        expect(response).to match_response_schema('equipment/equipment_list')
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
        equipment: {
          name: 'Synchrotron+',
          kind: 'synchrotron',
          serial_number: 'RE-777-888-99'
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

        it 'returns equipment json schema' do
          post :create, params: params
          expect(response).to match_response_schema('equipment/equipment')
        end

        it 'saves new equipment in the database' do
          expect { post :create, params: params }.to change(Equipment, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            equipment: attributes_for(:invalid_equipment),
            format: :json
          }
        end

        it 'returns 422 status code' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the equipment in the database' do
          expect { post :create, params: invalid_params }.not_to change(Equipment, :count)
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

  describe 'GET #show' do
    let!(:equipment) { create(:equipment) }

    context 'when user authenticated' do
      sign_in_staff

      before { get :show, params: { id: equipment.id, format: :json } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns equipment json schema' do
        expect(response).to match_response_schema('equipment/equipment')
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        get :show, params: { id: equipment.id, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
