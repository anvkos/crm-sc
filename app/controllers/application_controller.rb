class ApplicationController < ActionController::Base
  devise_group :user, contains: [:staffs_staff, :clients_client]

  def after_sign_in_path_for(resource)
    self.send("#{resource.class.to_s.downcase.pluralize}_root_path")
  end
end
