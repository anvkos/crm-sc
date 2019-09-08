class Staffs::IndexController < ApplicationController
  before_action :authenticate_staffs_staff!

  def index
  end
end
