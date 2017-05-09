class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_and_authorize_resource, only: [:show, :edit, :update, :destroy, :edit_roster, :update_roster]
  before_action :authorize_resource, except: [:show, :edit, :update, :destroy, :edit_roster, :update_roster]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
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
    @team = Team.new(resource_params)
    @team.created_by = current_user
    @team.captain = current_user

    respond_to do |format|
      if @team.save
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
      if (captain_id = resource_params.dig(:roster, :captain_id)).present?
        u = @team.users.find_by(id: captain_id)
        return redirect_to edit_roster_team_url(@team), alert: 'Captain could not be found' if u.blank?

        @team.update(captain: u)
      end
    when 'update_players'
      player_ids = resource_params.dig(:roster, :player_ids)
      player_roles = resource_params.dig(:roster, :roles)
      if [player_ids, player_roles].all?(&:present?)
        player_ids.zip(player_roles).each do |id, role|
          m = @team.members.find_by(user_id: id)
          return redirect_to edit_roster_team_url(@team), alert: 'Player could not be found' if m.blank?

          m.update(role: role) if Member.roles.keys.include?(role)
        end
      end
    when 'remove_player'

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_and_authorize_resource
    authorize @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:team).permit(:name, :description, :location, roster: [:captain_id, player_ids: [], roles: []])
  end
end
