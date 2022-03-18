class Api::V1::UsersController < ApplicationController
  def get_current_user
    if user_signed_in?
      render :json => current_user
    end
  end
end
