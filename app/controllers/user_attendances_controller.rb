class UserAttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:attend, :absent]
  before_action :set_and_authorize_resource, only: [:attend, :absent]

  def attend
    @attendance_record.attending!
    game = Game.find(params[:game_id])
    redirect_to game, notice: 'Attending the game.'
  end

  def absent
    @attendance_record.absent!
    game = Game.find(params[:game_id])
    redirect_to game, notice: 'Not attending the game.'
  end

  def set_attendance
    @attendance_record = UserAttendance.find_by(token: params[:token])
    params[:attending] == 'true' ? @attendance_record.attending! : @attendance_record.absent!
    @attendance_record.clear_token!
    redirect_to '/', notice: 'Attendance has been tracked'
  end

  private

  def set_and_authorize_resource
    authorize @attendance_record = UserAttendance.find(params[:id])
  end
end
