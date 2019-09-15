class Staffs::IndexController < ApplicationController
  before_action :authenticate_staffs_staff!
  layout 'staffs'

  def index
  end
end
