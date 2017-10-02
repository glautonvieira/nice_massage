class WelcomeController < ApplicationController
  def show
    if current_user
      redirect_to '/panel/appointments'
    else
      redirect_to '/auth/google_oauth2'
    end
  end
end
