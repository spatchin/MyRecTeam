class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if @user.admin?
      scope.joins(:members).where('members.user_id = :q OR teams.user_id = :q', q: @user.id)
    end
  end

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
    @user.try(:admin?) || @record.captain?(@user)
  end

  def update?
    edit?
  end

  def edit_roster?
    edit?
  end

  def update_roster?
    update?
  end

  def destroy?
    @user.try(:admin?) || @record.created_by?(@user)
  end

  def add_player?
    update?
  end

  def remove_player?
    update?
  end
end
