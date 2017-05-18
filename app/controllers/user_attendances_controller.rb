class UserAttendancesController < ApplicationController
  def attend_game
  end

  def absent_game
  end

  private

  def resource_params
    params.require(:user_attendance).permit(:status, :token, :game_id, :team_id, :user_id)
  end
end
