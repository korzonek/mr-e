class RequestsController < ApplicationController
  def new
    @mystery = Mystery.find(params[:mystery_id])
    @request = @mystery.requests.new(user: current_user)
    authorize @request
  end
end
