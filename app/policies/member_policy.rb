class MemberPolicy < ApplicationPolicy
  def accept_invite?
    @record.user == @user && @record.token.present?
  end

  def deny_invite?
    @record.user == @user && @record.token.present?
  end
end
