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
    mystery.is_published || user == mystery.admin
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
    user.present? && user != mystery.admin && mystery.users.exclude?(user)
  end

  def leave?
    user.present? && user != mystery.admin && mystery.users.include?(user)
  end

  def unpublish?
    user == mystery.admin && mystery.is_published
  end

  def publish?
    user == mystery.admin && !mystery.is_published
  end

  def my_mysteries?
    user.present?
  end

end
