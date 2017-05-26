class PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_resource, only: [:show, :update, :destroy]
  before_action :authorize_resource, except: [:show, :update, :destroy]

  def show

  end

  def create
    @preference = Preference.new(resource_params)

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    debugger
    @preference.game_email_reminder = resource_params[:game_email_reminder].to_time

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_and_authorize_resource
    authorize @preference = Preference.find(params[:id])
  end

  def resource_params
    params.require(:preference).permit(:user_id, :game_email_reminder)
  end
end
