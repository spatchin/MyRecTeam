class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if @user.admin?
      scope.join(:user_attendances).where('user_attendances.user_id = ? OR games.user_id = ?', @user.id, @user.id)
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    @user.try(:captain?) || @user.admin?
  end

  def create?
    new?
  end

  def edit?
    @user.try(:admin?) || @record.created_by?(@user)
  end

  def update?
    edit?
  end

  def destroy?
    @user.try(:admin?) || @record.created_by?(@user)
  end
end
