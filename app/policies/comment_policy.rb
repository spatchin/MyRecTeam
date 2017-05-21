class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    @user.admin? || @record.commenter == @user
  end

  def destroy?
    update?
  end
end

