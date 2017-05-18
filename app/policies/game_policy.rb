class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        # scope.where(created_by: @user)
        @user.teams
      end
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
