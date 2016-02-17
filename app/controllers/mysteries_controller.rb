class MysteriesController < ApplicationController
  before_action :get_mystery, only: [:show, :join, :leave, :publish, :unpublish]

  def index
    @mysteries = Mystery.published
    authorize @mysteries
  end

  def my_mysteries
    @mysteries_as_admin = Mystery.where(admin: current_user)
    @mysteries_as_solver = current_user.mysteries
    authorize Mystery
  end

  def show
    @requests = @mystery.requests.where(user: current_user)
    @requestt = @mystery.requests.new
    @request = @mystery.requests.first
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

  def publish
    if @mystery.update(is_published: true)
      redirect_to @mystery, notice: "#{@mystery.name} is now published. It means that everybody can join and solve it! :)"
    else
      render @mystery, notice: "There was a problem with publishing #{@mystery.name} :( Please try again later..."
    end
  end

  def unpublish
    if @mystery.update(is_published: false)
      redirect_to @mystery, notice: "#{@mystery.name} is now unpublished. It means that only you can see it :)"
    else
      render @mystery, notice: "There was a problem with unpublishing #{@mystery.name} :( Please try again later..."
    end
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
