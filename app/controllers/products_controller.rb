class ProductsController < ApplicationController
  before_action :login_required, :set_last_request!
  def index

  end
end
