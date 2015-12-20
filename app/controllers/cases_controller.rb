class CasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :get_case, only: [:show, :join, :leave]

  def index
    @cases = Case.published
  end

  def show
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

  def join
    @case.participants.create(user: current_user)
    redirect_to @case, notice: "You've successfully joined the case :)"
  end

  def leave
    @case.participants.where(user: current_user).destroy_all
    redirect_to @case, notice: "You're no longer solving this case."
  end

  private
  def get_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:name, :description)
  end
end
