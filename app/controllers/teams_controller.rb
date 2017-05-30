class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_resource, only: [:show, :edit, :update, :destroy, :edit_roster, :update_roster, :add_player, :remove_player]
  before_action :authorize_resource, except: [:show, :edit, :update, :destroy, :edit_roster, :update_roster, :add_player, :remove_player]

  # GET /teams
  # GET /teams.json
  def index
    @teams = policy_scope(Team).page(params[:page])
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  def edit_roster
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.created_teams.new(resource_params)
    @team.captain = current_user

    respond_to do |format|
      if @team.save
        @team.starters << current_user

        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(resource_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_roster
    case params[:subaction]
    when 'update_captain'
      unless @team.update(captain_id: resource_params.dig(:roster, :captain_id))
        redirect_to edit_roster_team_url(@team), alert: 'Captain could not be found' and return
      end
    when 'update_players'
      player_ids = resource_params.dig(:roster, :player_ids)
      player_roles = resource_params.dig(:roster, :roles)
      if [player_ids, player_roles].all?(&:present?)
        player_ids.zip(player_roles).each do |id, role|
          m = @team.members.find_by(user_id: id)
          redirect_to edit_roster_team_url(@team), alert: 'Player could not be found' and return if m.blank?

          m.update(role: role) if Member.roles.keys.include?(role)
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to edit_roster_team_url(@team), notice: 'Team was successfully updated.' }
      format.json { render :show, status: :ok, location: @team }
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_player
    # create member or resend invite if member already exists
    email = resource_parmas[:email].try(:strip).try(:downcase)
    user = User.find_by(email: email)

    if @team.users.include?(user)
      return redirect_to edit_roster_team_url(@team), alert: 'User is already on the team.'
    end

    if user.blank?
      User.invite!({email: email}, current_user)
    end

    @team.alternates << user
    member = @team.members.last

    # send email with link that updates member accepted at
    member.generate_token!
    accept_link = accept_invite_members_url(token: member.token)
    deny_link = deny_invite_members_url(token: member.token)
    TeamMailer.add_player_email(accept_link, deny_link, @team, user).deliver_later
    redirect_to edit_roster_team_url(@team), notice: 'User was invited.'
  end

  def remove_player
    removed_member = @team.members.find_by(user_id: resource_params.dig(:roster, :player_ids).try(:first))
    return redirect_to edit_roster_team_url(@team), alert: 'User could not be removed.' unless removed_member.present?

    @team.members.destroy(removed_member)
    redirect_to edit_roster_team_url(@team), notice: 'User was successfully removed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_and_authorize_resource
    authorize @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:team).permit(:name, :description, :location, :email, :captain_id, roster: [:captain_id, player_ids: [], roles: []])
  end
end
