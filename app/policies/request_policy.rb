class RequestPolicy < ApplicationPolicy
  attr_reader :user, :request, :mystery

  def initialize(user, request)
    @user = user
    @request = request
    @mystery = @request.mystery
  end

  def create?
    mystery.users.include?(user)
  end

  def update?
    user == request.user
  end

  def destroy?
    user == request.user || user == mystery.admin
  end
end
