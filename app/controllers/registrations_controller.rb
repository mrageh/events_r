class RegistrationsController < ApplicationController
  before_action :find_event
  before_action :require_signin

  def index
    @registrations = @event.registrations
  end

  def new
    @registration = @event.registrations.new
  end

  def create
    @registration = @event.registrations.create(registration_params)
    @registration.user = current_user
    if @registration.save
      redirect_to event_registrations_path(@event),
        notice: "Thanks for registering #{current_user.name}!"
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:how_heard)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
