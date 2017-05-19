class UserAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_resource

  def attend
    game = Game.find(params[:game_id])
    @attendance_record.attending!
    redirect_to game, notice: 'Attending the game.'
  end

  def absent
    game = Game.find(params[:game_id])
    @attendance_record.absent!
    redirect_to game, notice: 'Not attending the game.'
  end

  private

  def set_and_authorize_resource
    authorize @attendance_record = UserAttendance.find(params[:id])
  end
end
