class Api::V1::Users::ProfilesController < Api::V1::ApplicationController
  before_action :define_user

  def new
    @profile = @user.build_profile
  end

  def create
    oparation = Profiles::CreatedProfile
                .call(params: permit_params(:profile).merge(user_id: @user.id))
  end
  #   # def edit; end
  #   # def update; end
  #   # def destroy; end

  private

  def define_user
    @user = current_user
  end
end
