class MysteryPolicy < ApplicationPolicy
  attr_reader :user, :mystery

  def initialize(user, mystery)
    @user = user
    @mystery = mystery
  end

  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user == mystery.admin
  end

  def destroy?
    user == mystery.admin
  end

  def join?
    mystery.users.exclude? user
  end

  def leave?
    !join?
  end

end
