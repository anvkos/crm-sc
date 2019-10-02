require 'rails_helper'

RSpec.describe Staffs::StaffsController, type: :controller do
  describe "GET #index" do
    before { create_list(:staff, 2) }

    context 'when user authenticated' do
      sign_in_staff
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of staffs' do
        expect(response.body).to have_json_size(3).at_path('data')
      end

      it 'returns staffs json schema' do
        expect(response).to match_response_schema('staffs/staffs')
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
        staff: {
          fullname: 'full_name',
          email: 'test@test.com',
          password: 'q1w2e3'
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

        it 'returns staff json schema' do
          post :create, params: params
          expect(response).to match_response_schema('staffs/staff')
        end

        it 'saves new staff in the database' do
          expect { post :create, params: params }.to change(Staff, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            staff: {
              fullname: nil,
              email: nil,
              password: nil
            },
            format: :json
          }
        end

        it 'returns 422 status code' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the staff in the database' do
          expect { post :create, params: invalid_params }.not_to change(Staff, :count)
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
    let!(:staff) { create(:staff) }

    context 'when user authenticated' do
      sign_in_staff

      before { get :show, params: { id: staff.id, format: :json } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns staff json schema' do
        expect(response).to match_response_schema('staffs/staff')
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        get :show, params: { id: staff.id, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:staff) { create(:staff) }
    let(:update_params) do
      {
        fullname: 'updated_name',
        email: 'uplated_email@test.com'
      }
    end

    context 'when user authenticated' do
      sign_in_staff

      before { patch :update, params: { id: staff.id, staff: update_params, format: :json } }

      context 'with valid attributes' do
        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'change staff attributes' do
          staff.reload
          expect(staff.fullname).to eq update_params[:fullname]
          expect(staff.email).to eq update_params[:email]
        end

        it 'returns staff json schema' do
          expect(response).to match_response_schema('staffs/staff')
        end
      end

      context 'with invalid attributes' do
        let(:invalid_params) do
          {
            fullname: nil,
            email: 'invalid'
          }
        end

        before { patch :update, params: { id: staff.id, staff: invalid_params, format: :json } }

        it 'returns 422 status code' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'do not change staff attributes' do
          staff.reload
          expect(staff.fullname).not_to eq invalid_params[:fullname]
          expect(staff.email).not_to eq invalid_params[:email]
        end
      end
    end

    context 'when user is not unauthorized' do
      it 'returns 401 status code' do
        patch :update, params: { id: staff.id, staff: update_params, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
