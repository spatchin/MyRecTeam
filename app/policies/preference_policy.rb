class PreferencePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: @user)
    end
  end

  def show?
    @record.user == @user || @user.admin?
  end

  def create?
    true
  end

  def update?
    @record.user == @user || @user.admin?
  end

  def destroy?
    @record.user == @user || @user.admin?
  end
end
