class MembersController < ApplicationController
  # don't check authorization in order to be able to accept/deny through email
  def accept_invite
    @member = if params[:token].present?
                @member = Member.find_by(token: params[:token])
              else
                nil
              end
    return redirect_to root_url, alert: 'Invitation could not be accepted.' if @member.nil?

    @member.accept!
    @member.clear_token!
    redirect_to @member.team, notice: 'Invitation accepted.'
  end

  def deny_invite
    @member = if params[:token].present?
                @member = Member.find_by(token: params[:token])
              else
                nil
              end
    return redirect_to root_url, alert: 'Invitation could not be denied.' if @member.nil?

    @member.destroy
    flash[:notice] = 'Invitation denied.'
    redirect_to user_signed_in? ?  teams_url : root_url
  end
end
