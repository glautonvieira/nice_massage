class WelcomeController < ApplicationController
  def show
    redirect_to '/panel/appointments' if current_user
  end
end
