module ControllerMacros
  def sign_in_staff
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:staff]
      staff = FactoryBot.create(:staff)
      sign_in staff
    end
  end

  def sign_in_client
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:client]
      client = FactoryBot.create(:client)
      sign_in client
    end
  end
end