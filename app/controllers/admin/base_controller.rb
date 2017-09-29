module Admin
  class BaseController < ApplicationController
    layout 'admin'

    helper_method :check_flag_admin
    before_action :check_flag_admin

    def check_flag_admin
      redirect_to '/' unless (current_user && current_user.is_admin?)
    end

    private

    def mocked_user
      user = User.find_by(name: 'Jackie Chan')
      return user unless user.nil?

      user = User.create(
        name: 'Jackie Chan',
        email: 'jackie@chan.com'
      )
    end
  end
end
