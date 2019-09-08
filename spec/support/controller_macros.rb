module ControllerMacros
  def sign_in_staff
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:staff]
      staff = FactoryBot.create(:staff)
      sign_in staff
    end
  end
end