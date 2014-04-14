class LikesController < ApplicationController
  before_action :require_signin
  before_action :find_event

  def create
    @event.likes.create(user: current_user)
    redirect_to @event, notice: 'Glad you liked it!'
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_to @event, notice: 'Sorry to hear that!'
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
