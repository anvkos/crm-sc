class ApplicationController < ActionController::Base
  devise_group :user, contains: %i[staff client]

  def after_sign_in_path_for(resource)
    send("#{resource.class.to_s.downcase.pluralize}_root_path")
  end
end
