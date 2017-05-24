class UserAttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:attend, :absent]
  before_action :set_and_authorize_resource, only: [:attend, :absent]

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

  def update_from_email
    @attendance_record = UserAttendance.find(params[:token])
    params[:attendance] == 'attending' ? @attendance_record.attending! : @attendance_record.absent!
    @attendance_record.clear_token!
    redirect_to '/', notice: 'Attendance has been tracked'
  end

  private

  def set_and_authorize_resource
    authorize @attendance_record = UserAttendance.find(params[:id])
  end
end
