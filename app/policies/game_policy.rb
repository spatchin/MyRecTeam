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
    @record.team.captain?(@user) || @record.created_by?(@user) || @user.try(:admin?)
  end

  def update?
    edit?
  end

  def destroy?
    @record.team.captain?(@user) || @user.try(:admin?)
  end
end
