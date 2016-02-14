class RequestPolicy < ApplicationPolicy
  attr_reader :user, :request, :mystery

  def initialize(user, request)
    @user = user
    @request = request
    @mystery = @request.mystery
  end

  def new?
    @mystery.users.include?(user)
  end
end
