class MembersController < ApplicationController
  def accept_invite
    @member = Member.find_by(token: params[:token])
    redirect_to root_url, alert: 'Invitation could not be accepted.' if @member.blank?

    @member.accept!
    redirect_to @member.team, notice: 'Invitation accepted.'
  end

  private

  def resource_params
    params.require(:member).permit(:role, :accepted_at, :token)
  end
end
