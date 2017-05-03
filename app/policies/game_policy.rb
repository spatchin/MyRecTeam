class GamePolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     if @user.admin?
  #       scope.all
  #     else
  #       scope.where(created_by: @user)
  #     end
  #   end
  # end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    @user
  end

  def create?
    @user
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
