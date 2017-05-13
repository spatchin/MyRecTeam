class TeamPolicy < ApplicationPolicy
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
    @user.try(:admin?) || @record.is_key_person?(@user)
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
