class UserAttendancePolicy < ApplicationPolicy
  def attend?
    @record.user == @user
  end

  def absent?
    @record.user == @user
  end
end
