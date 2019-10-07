class Staffs::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found

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

  def respond_with_not_found(exception)
    render_error :not_found,
                 name: "Not found",
                 message: exception.message
  end
end
