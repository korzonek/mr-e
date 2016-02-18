class RequestPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def destroy?
    user == request.user
  end

end
