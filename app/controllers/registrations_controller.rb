class RegistrationsController < ApplicationController

  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations.all
  end

  def new
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.new
  end

  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.create(registration_params)
    if @registration.save
      redirect_to event_registrations_path(@event), notice: "Thanks for registering!"
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:full_name, :email, :how_heard)
  end
end
