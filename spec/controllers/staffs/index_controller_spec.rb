require 'rails_helper'

RSpec.describe Staffs::IndexController, type: :controller do
  describe "GET #index" do
    sign_in_staff
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #index" do
    sign_in_staff
    before { get :user }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns staff json schema' do
      expect(response).to match_response_schema('staffs/staff')
    end
  end
end
