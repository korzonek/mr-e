class CasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :get_case, only: [:show, :join]
  before_action :joined_already, only: :join

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
    if Participant.create(user: current_user, case: @case)
      redirect_to @case, notice: "You've successfully joined the case :)"
    end
  end

  def leave

  end

  private
  def get_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:name, :description)
  end

  def joined_already
    if Participant.where(case: @case, user: current_user).any?
      redirect_to @case, alert: "You've already joined this case."
    end
  end
end
