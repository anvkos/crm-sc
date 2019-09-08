require 'rails_helper'

RSpec.describe Clients::IndexController, type: :controller do

  describe "GET #index" do
    sign_in_client

    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

end
