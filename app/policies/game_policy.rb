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
    @user.admin? || @team.captain?(@user) || @team.users.include?(@user)
  end

  def new?
    @user.try(:captain?) || @user.admin?
  end

  def create?
    new?
  end

  def edit?
    @record.team.captain?(@user) || @user.try(:admin?)
  end

  def update?
    edit?
  end

  def destroy?
    @record.team.captain?(@user) || @user.try(:admin?)
  end

  def complete?
    @record.pending? && edit?
  end

  def cancel?
    @record.pending? && edit?
  end
end
