class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(created_by: @user)
      end
    end
  end

  def index?
  end

  def show?
  end

  def new?
  end

  def create?
  end

  def edit?
  end

  def update?
  end

  def destroy?
  end
end
