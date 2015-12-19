class CasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @cases = Case.published
  end

  def show
    @case = Case.find(params[:id])
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)
    @case.admin = current_user
    if @case.save
      redirect_to @case, notice: "Here are your new case. It is unpublished for now. Please add some initial info and when you're ready, click the 'Publish' button :)"
    else
      render 'new'
    end
  end

  private

  def case_params
    params.require(:case).permit(:name, :description)
  end
end
