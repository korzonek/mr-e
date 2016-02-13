class MysteriesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :get_mystery, only: [:show, :join, :leave]

  def index
    @mysteries = Mystery.published
    authorize @mysteries
  end

  def show
  end

  def new
    @mystery = Mystery.new
    authorize @mystery
  end

  def create
    @mystery = Mystery.new(mystery_params)
    authorize @mystery
    @mystery.admin = current_user
    if @mystery.save
      redirect_to @mystery, notice: "Here is your new mystery. It is unpublished for now. Please add some initial info and when you're ready, click the 'Publish' button :)"
    else
      render 'new'
    end
  end

  def join
    @mystery.participants.create(user: current_user)
    redirect_to @mystery, notice: "You've successfully joined the mystery :)"
  end

  def leave
    @mystery.participants.where(user: current_user).destroy_all
    redirect_to @mystery, notice: "You're no longer solving this mystery."
  end

  private

  def get_mystery
    @mystery = Mystery.find(params[:id])
    authorize @mystery
  end

  def mystery_params
    params.require(:mystery).permit(:name, :description)
  end
end
