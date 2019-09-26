class Staffs::BaseController < ApplicationController
  before_action :authenticate_staff!

  protected

  def respond_with_validation_error(model, errors = nil)
    render_error :unprocessable_entity,
                 message: "Validation failed",
                 errors: (errors || model.errors)
  end

  def render_error(status, resource = nil)
    render status: status,
           json: (resource || { message: "error" })
  end
end
