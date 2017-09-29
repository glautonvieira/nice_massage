module Panel
  class AppointmentsController < ApplicationController
    def index
      check_if_logged
      @appointments_presenter = AppointmentsPresenter.new(current_user)
    end

    def create
      check_if_logged
      @massage = schedule_massage
      if @massage.persisted?
        flash[:notice] = t('.massage_has_been_scheduled')
        redirect_to root_path
      else
        flash[:alert] = @massage.errors.messages[:timetable].first
        redirect_to :back
      end
    end

    def new
      check_if_logged
      return unless schedule_is_open
      @massage = Massage.new
      @massage_dates = date_finder.massage_dates
    end

    def destroy
      check_if_logged
      appointment = Massage.find(params[:id])
      if appointment.cancel!
        flash[:notice] = t('.cancelled')
      else
        flash[:alert] = t('.cannot_cancel')
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('.appointment_not_found')
    ensure
      redirect_to root_path
    end

    private

    def check_if_logged
      redirect_to '/' if !current_user
    end

    def schedule_is_open
      # @schedule_is_open ||= \
      #   Schedule::Checker.new(Time.zone.now).schedule_is_open?
      @schedule_is_open = true
    end

    def date_finder
      Schedule::MassageDateFinder.new(Time.zone.today)
    end

    def available_timetables(date)
      Schedule::TimetablesPresenter.new(date).available_timetables
    end

    def schedule_massage
      Schedule::MassageScheduler.new(massage_params).schedule_massage
    end

    def massage_params
      params.permit(:user, :timetable).merge(user: current_user)
    end
  end
end
