class UserAttendancePolicy < ApplicationPolicy
  def attend?
    (@record.user == @user && @record.game.pending?) || @record.team.captain?(@user)
  end

  def absent?
    attend?
  end
end
