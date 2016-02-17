class RequestsController < ApplicationController
  def create
    @mystery = Mystery.find(params[:mystery_id])
    @request = @mystery.requests.new(request_params)
    @request.user = current_user
    authorize @request
    respond_to do |format|
      if @request.save
        format.js
      end
    end
  end

  private

  def request_params
    params.require(:request).permit(:content)
  end
end
